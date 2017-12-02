//
//  ViewController.swift
//  ReachabilityDemo
//
//  Created by Emil Atanasov on 1.12.17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//
//  Примерът с AsyncDisplayKit е базиран на кода от
//  основното репозитори - https://github.com/TextureGroup/Texture/tree/master/examples/Swift/Sample
//

import UIKit
import Reachability
import AsyncDisplayKit


class ViewController: ASViewController<ASDisplayNode>, ASTableDataSource, ASTableDelegate {
    
    // MARK:- Reachability
    
    let reachability = Reachability()!
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

    // MARK:- Texture
    
    struct State {
        var itemCount: Int
        var fetchingMore: Bool
        static let empty = State(itemCount: 20, fetchingMore: false)
    }
    
    enum Action {
        case beginBatchFetch
        case endBatchFetch(resultCount: Int)
    }
    
    // връща основното view, което е ASDisplayNode
    var tableNode: ASTableNode {
        return node as! ASTableNode
    }
    
    fileprivate(set) var state: State = .empty
    
    init() {
        //определяме основното view като ASTableNode
        super.init(node: ASTableNode())
        tableNode.delegate = self
        tableNode.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        //определяме основното view като ASTableNode
        super.init(node: ASTableNode())
        //делегатите сме самите ние, тук е добре да се разделят
        tableNode.delegate = self
        tableNode.dataSource = self
    }
    
    // MARK: ASTableNode data source and delegate
    // какъв ще е елемента, който трябва да покажем на съответния ред/индекс?
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        // Should read the row count directly from table view but
        // https://github.com/facebook/AsyncDisplayKit/issues/1159
        let rowCount = self.tableNode(tableNode, numberOfRowsInSection: 0)
        //само последния елемент е от специалния вид с прелоудър
        if state.fetchingMore && indexPath.row == rowCount - 1 {
            let node = MyCellNode()
            node.style.height = ASDimensionMake(44.0)
            return node;
        }
        //основния тип елемент съдържа текст
        let node = ASTextCellNode()
        node.text = String(format: "[%ld.%ld] says hello!", indexPath.section, indexPath.row)
        
        return node
    }
    //броя на секции в таблицата
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    //броя на елементи в секция
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        var count = state.itemCount
        if state.fetchingMore {
            count += 1
        }
        return count
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        /// This call will come in on a background thread. Switch to main
        /// to add our spinner, then fire off our fetch.
        DispatchQueue.main.async {
            let oldState = self.state
            self.state = ViewController.handleAction(.beginBatchFetch, fromState: oldState)
            self.renderDiff(oldState)
        }
        //асинхронно сваляне на информация с извикване на хендлър
        ViewController.fetchDataWithCompletion { resultCount in
            let action = Action.endBatchFetch(resultCount: resultCount)
            let oldState = self.state
            self.state = ViewController.handleAction(action, fromState: oldState)
            self.renderDiff(oldState)
            context.completeBatchFetching(true)
        }
    }
    
    fileprivate func renderDiff(_ oldState: State) {
        //избразяване на промените
        self.tableNode.performBatchUpdates({
            
            // Add or remove items
            let rowCountChange = state.itemCount - oldState.itemCount
            if rowCountChange > 0 {
                let indexPaths = (oldState.itemCount..<state.itemCount).map { index in
                    IndexPath(row: index, section: 0)
                }
                tableNode.insertRows(at: indexPaths, with: .none)
            } else if rowCountChange < 0 {
                assertionFailure("Deleting rows is not implemented. YAGNI.")
            }
            
            // Add or remove spinner.
            if state.fetchingMore != oldState.fetchingMore {
                if state.fetchingMore {
                    // Add spinner.
                    let spinnerIndexPath = IndexPath(row: state.itemCount, section: 0)
                    tableNode.insertRows(at: [ spinnerIndexPath ], with: .none)
                } else {
                    // Remove spinner.
                    let spinnerIndexPath = IndexPath(row: oldState.itemCount, section: 0)
                    tableNode.deleteRows(at: [ spinnerIndexPath ], with: .none)
                }
            }
        }, completion:nil)
    }
    
    /// (Pretend) fetches some new items and calls the
    /// completion handler on the main thread.
    fileprivate static func fetchDataWithCompletion(_ completion: @escaping (Int) -> Void) {
        let time = DispatchTime.now() + Double(Int64(TimeInterval(NSEC_PER_SEC) * 1.0)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            let resultCount = Int(arc4random_uniform(20))
            completion(resultCount)
        }
    }
    //обработване на действието и отразяване на промените в модела/състоянието
    fileprivate static func handleAction(_ action: Action, fromState state: State) -> State {
        var state = state
        switch action {
        case .beginBatchFetch:
            state.fetchingMore = true
        case let .endBatchFetch(resultCount):
            state.itemCount += resultCount
            state.fetchingMore = false
        }
        return state
    }
}


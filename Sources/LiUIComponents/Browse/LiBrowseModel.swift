// Copyright 2018 Lithium Technologies 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import LiCore
public class LiBrowseModel {
    var nodes: [LiBrowse]
    var categories = [String: [LiBrowse]]()
    var boards = [String: [LiBrowse]]()
    public init?(data: [LiBaseModel]) {
        guard let browseData = data as? [LiBrowse] else {
            return nil
        }
        nodes = browseData
        organiseCategories()
    }
    ///Adds boards to the given level.
    /// - parameter forLevel: Level at which the boards data belong.
    /// - parameter data: Data of the boards.
    func addBoards(forLevel level: String, data: [LiBaseModel]) {
        guard let browseData = data as? [LiBrowse] else {
            return
        }
        boards[level] = browseData
    }
    ///Checks if data of boards at the given level is present.
    /// - parameter forLevel: Level at which data is being checked for.
    /// - returns: 'True' if data is present and 'False' otherwise.
    func hasBoardData(forLevel level: String) -> Bool {
        if let subBoards = boards[level] {
            if subBoards.isEmpty {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    ///Checks if data of categories at the given level is present.
    /// - parameter forLevel: Level at which data is being checked for.
    /// - returns: 'True' if data is present and 'False' otherwise.
    func hasCategoriesData(forLevel level: String) -> Bool {
        if let subcategories = categories[level] {
            if subcategories.isEmpty {
                return false
            } else {
                return true
            }
        } else { return false }
    }
    ///Function to get the depth of the root of the browse tree.
    /// - returns: Depth of the root of the browse tree.
    func getDepthOfRoot() -> Int? {
        return nodes.map { $0.depth ?? 0 }.min()
    }
    ///Organises categories in a dictionary where the key is parent 'String' and values are child '[LiBrowse]'
    ///For the nodes at root the default parent name is always 'root'. For rest the parent name is the 'id' of the parent node.
    func organiseCategories() {
        if let rootDepth = getDepthOfRoot() {
            for elm in nodes {
                if elm.depth == rootDepth {
                    var elements = categories["root"] ?? []
                    elements.append(elm)
                    categories["root"] = elements
                } else {
                    guard let key = elm.parent?.id else {
                        assert(true, "category id is nil")
                        return
                    }
                    var elements = categories[key] ?? []
                    elements.append(elm)
                    categories[key] = elements
                }
            }
        }
    }
    ///Get number of categories and boards for a given level.
    /// - parameter inSection: Section of the tableView. 0 - Categories. 1 - Boards
    /// - parameter atLevel: Level for which the data is requested.
    /// - returns: Number of elements.
    func numberOfRows(inSection section: Int, atLevel level: String) -> Int {
        switch section {
        case 0:
            return categories[level]?.count ?? 0
        case 1:
            return boards[level]?.count ?? 0
        default:
            return 0
        }
    }
    ///Returns the id for the level that the user has requested.
    /// - parameter givenCurrentLevel: Level at which the user is currently browsing.
    /// - parameter indexPath: Location of level in the array.
    /// - returns: Id of the next level.
    func getNextLevel(givenCurrentLevel currentLevel: String, indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return categories[currentLevel]![indexPath.row].id ?? ""
        case 1:
            return boards[currentLevel]![indexPath.row].id ?? ""
        default:
            return "root"
        }
    }
    ///Returns the navigation bar title for the level that the user has requested.
    /// - parameter givenCurrentLevel: Current level the user is at.
    /// - parameter indexPath: indexPath of the tableview.
    /// - returns: Tuple containing the title of current level and the next level, in that order.
    func getLevelTitle(givenCurrentLevel currentLevel: String, indexPath: IndexPath) -> (String, String) {
        switch indexPath.section {
        case 0:
            let one = categories[currentLevel]![indexPath.row].title ?? ""
            let two = categories[currentLevel]![indexPath.row].parent?.title ?? ""
            return (one, two)
        default:
            return ("", "")
        }
    }
    ///Returns selected board
    /// - parameter at: Index in tableview
    /// - parameter currentLevel: Current level in browse
    /// - returns: LiBrowse object of the board that was requested
    func getBoard(at index: Int, currentLevel: String) -> LiBrowse {
        return boards[currentLevel]![index]
    }
}

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

public class LiQuerySetting {
    fileprivate static let whereCondition = "where-condition"
    fileprivate static let order = "order"
    fileprivate static let limit = "limit"
    public struct Ordering {
        var key: String
        var type: String
        init?(data: [String: String]?) {
            guard let key = data?["key"],
                let type = data?["type"] else {
                    return nil
            }
            self.key = key
            self.type = type
        }
        func toString() -> String {
            return key + " " + type
        }
    }
    public struct WhereClause {
        var clause: LiWhereClause
        var key: String
        var value: String
        var `operator`: String
        init?(data: [String: String]) {
            guard let clause = LiWhereClause(rawValue: data["clause"]!),
                let key = data["key"],
                let value = data["value"],
                let `operator` = data["operator"] else {
                    print("WhereClause set failure")
                    return nil
            }
            self.clause = clause
            self.key = key
            self.value = value
            self.`operator` = `operator`
        }
        func toString() -> String {
            return key + " " + clause.getString() + " " + value
        }
    }
    public fileprivate(set) var whereClauses: [WhereClause]
    public fileprivate(set) var ordering: [Ordering]?
    public fileprivate(set) var limit: String?
    public init(whereClauses: [WhereClause], ordering: [Ordering], limit: String) {
        self.whereClauses = whereClauses
        self.ordering = ordering
        self.limit = limit
    }
    init?(data: [String: Any]) {
        if let clauseArray = data["whereClauses"] as? [[String: String]] {
            var tempWhereClauses: [WhereClause] = []
            for elm in clauseArray {
                guard let clause = WhereClause(data: elm) else {
                    print("Where clause set error")
                    break
                }
                tempWhereClauses.append(clause)
            }
            self.whereClauses = tempWhereClauses
        } else {
            self.whereClauses = []
        }
        if let orderingArray = data["ordering"] as? [[String: String]] {
            var tempOrdering: [Ordering] = []
            for elm in orderingArray {
                guard let ordering = Ordering(data: elm) else {
                    print("Ordering set error")
                    break
                }
                tempOrdering.append(ordering)
            }
            self.ordering = tempOrdering
        } else {
            self.ordering = nil
        }
        if let limit = data["limit"] as? String {
            self.limit = limit
        } else {
            self.limit = nil
        }
    }
    public enum LiWhereClause: String {
        case equals
        case notEquals = "not-equals"
        case greaterThan = "greater-than"
        case greaterThanEquals = "greater-than-equals"
        case lessThan = "less-than"
        case lessThanEquals = "less-than-equal"
        case `in`
        case matches
        func getString() -> String {
            switch self {
            case .equals:
                return "="
            case .notEquals:
                return "!="
            case .greaterThan:
                return ">"
            case .greaterThanEquals:
                return ">="
            case .lessThan:
                return "<"
            case .lessThanEquals:
                return "<="
            case .in:
                return "in"
            case .matches:
                return "matches"
            }
        }
    }
    public enum LiClause: String {
        case `where`
        case order
        case limit
    }
}

import ballerina/graphql;

// Define the record type for Department Objectives
public type DeptObjective record {|
    readonly string id;
    string objective;
    decimal percentageContribution;
|};
table<DeptObjective> key(id) deptObjectivesTable = table [
    {id: "OBJ1", objective: "Increase Research Output", percentageContribution: 25},
    {id: "OBJ2", objective: "Enhance Student Success Rate", percentageContribution: 30},
    {id: "OBJ3", objective: "Improve Faculty Engagement", percentageContribution: 20}
];
// Define the record type for Key Performance Indicators (KPIs)
public type KPI record {|
    readonly string id;
    string indicator;
    string unit;
    decimal score;
    decimal target;
|};
table<KPI> key(id) kpiTable = table [
    {id: "KPI1", indicator: "Peer Recognition", unit: "score", score: 4, target: 5},
    {id: "KPI2", indicator: "Student Progress", unit: "percentage", score: 80, target: 90},
    {id: "KPI3", indicator: "Research Output", unit: "count", score: 10, target: 15}
];
// Define the record type for Employees
public type Employee record {|
    readonly string id;
    string firstName;
    string lastName;
    string jobTitle;
    string position;
    string role;
    KPI[] kpis;
|};

table<Employee> key(id) employeesTable = table [
    {id: "EMP1", firstName: "John", lastName: "Doe", jobTitle: "Lecturer", position: "Senior", role: "Supervisor", kpis: kpiTable.toArray()},
    {id: "EMP2", firstName: "Jane", lastName: "Doe", jobTitle: "Lecturer", position: "Junior", role: "Employee", kpis: kpiTable.toArray()}
];

public distinct service class PerformanceData {
    private final readonly & Employee employeeRecord;

    function init(Employee employeeRecord) {
        self.employeeRecord = employeeRecord.cloneReadOnly();
    }

    // ... resource functions to expose Employee data, KPIs, etc.
}

service /performanceManagement on new graphql:Listener(9000) {
    resource function get allObjectives() returns DeptObjective[] {
        DeptObjective[] deptObjectives = deptObjectivesTable.toArray().cloneReadOnly();
        return deptObjectives;
    }

    resource function get filterObjectives(string id) returns DeptObjective? {
        DeptObjective? deptObjective = deptObjectivesTable[id];
        if deptObjective is DeptObjective {
            return deptObjective;
        }
        return;
    }

    resource function get allEmployees() returns PerformanceData[] {
        Employee[] employees = employeesTable.toArray().cloneReadOnly();
        return employees.map(employee => new PerformanceData(employee));
    }

    resource function get filterEmployees(string id) returns PerformanceData? {
        Employee? employee = employeesTable[id];
        if employee is Employee {
            return new PerformanceData(employee);
        }
        return;
    }

    // ... other resource and remote functions for adding, updating, deleting objectives, KPIs, and employee data
}


import ballerina/graphql;
import ballerinax/sqlite;

service /graphql on new graphql:Listener(4000) {

    @graphql:Resource
    isolated function getEmployee(int employeeId) returns Employee {
        // Logic to retrieve employee from database
    }

    @graphql:Resource
    isolated function getKPI(int kpiId) returns KPI {
        // Logic to retrieve KPI from database
    }
}

public type Employee record {
    int employee_id;
    string first_name;
    string last_name;
    KPI kpi;
};

public type KPI record {
    int kpi_id;
    string description;
    Employee employee;
};

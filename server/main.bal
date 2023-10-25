import ballerina/graphql;

type Department record {
    string name;
    string hod;
    Objectives[] objectives;
};

type Employee record {
    string firstName;
    string lastName;
    string jobTitle;
    KPI[] kpis;
};

type Supervisor record {
    string firstName;
    string lastName;
    Employee[] supervisees;
};

type KPI record {
    string description;
    float score; // Assuming the score is a float value
};

type Objectives record {
    string description;
    float percentageContribution;
};

@graphql:ServiceConfig {
    // Service configuration
}
service / on new graphql:Listener(4000) {

    // Queries
    resource function get department(string name) returns Department {
        // Implementation
    }

    resource function get employee(string firstName, string lastName) returns Employee {
        // Implementation
    }

    resource function get supervisor(string firstName, string lastName) returns Supervisor {
        // Implementation
    }

    // Mutations for HoD
    remote function createDepartment(string name, string hod) returns Department {
        // Implementation
    }

    remote function deleteDepartment(string name) returns string {
        // Implementation
    }

    // Mutations for Supervisor
    remote function approveKPI(string employeeName, string kpiDescription) returns KPI {
        // Implementation
    }

    remote function deleteKPI(string employeeName, string kpiDescription) returns string {
        // Implementation
    }

    remote function updateKPI(string employeeName, string kpiDescription, float newScore) returns KPI {
        // Implementation
    }

    remote function gradeKPI(string employeeName, string kpiDescription, float grade) returns KPI {
        // Implementation
    }

    // Mutations for Employee
    remote function createKPI(string description, float score) returns KPI {
        // Implementation
    }

    remote function gradeSupervisor(string supervisorName, float grade) returns string {
        // Implementation
    }

}

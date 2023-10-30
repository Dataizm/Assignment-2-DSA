import ballerina/http;
import ballerina/graphql;
// Import the module where CovidEntry and CovidEntryInput are defined
// import your_module;

graphql:Client covidClient = check new ("http://localhost:9000/covid19");

function runQueries() returns error? {
    {
        string document1 = "query GetAll { all { country, cases, deaths, recovered, active } }";
        graphql:ClientError|json response1 = covidClient->execute(document1);
        if (response1 is graphql:ClientError) {
            // handle error
            return response1;
        } else {
            // process response
        }
    }

    {
        string document2 = "query GetByIsoCode($isoCode: String) { filter(isoCode: $isoCode) { country, cases, deaths, recovered, active } }";
        map<anydata> variables2 = {"isoCode": "US"};
        graphql:ClientError|json response2 = covidClient->execute(document2, variables2);
        if (response2 is graphql:ClientError) {
            // handle error
            return response2;
        } else {
            // process response
        }
    }

    {
        string document3 = "mutation AddEntry($entry: CovidEntryInput) { add(entry: $entry) { country } }";
        CovidEntry newEntry = {isoCode: "CAN", country: "Canada", cases: 1200000, deaths: 25000, recovered: 1150000, active: 25000};
        map<anydata> variables3 = {"entry": newEntry};
        graphql:ClientError|json response3 = covidClient->execute(document3, variables3);
        if (response3 is graphql:ClientError) {
            // handle error
            return response3;
        } else {
            // process response
        }
    }
}

public function main() returns error? {
    check runQueries();
}

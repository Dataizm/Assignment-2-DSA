import ballerina/graphql;

// import ballerina/io;

type Course record {
    readonly string code;
    string name;
    string description;
};

type CourseReq record {
    string code;
    string name;
    string description;
};

table<Course> key(code) courseTable = table [];

@graphql:ServiceConfig {
    graphiql: {
        enabled: true
    // Path is optional, if not provided, it will be dafulted to `/graphiql`.
    // path: "/testing"
    }
}
service / on new graphql:Listener(3000) {

    // function to get all courses
    resource function get getAllCourses() returns table<Course> {
        return courseTable;
    }

    resource function get getCourseByCode(string code) returns Course {
        Course foundCourse = courseTable.get(code);
        return foundCourse;
    }

    // GraphiQL

    remote function createCourse(CourseReq newCourse) returns string {
        var {code, ...data} = newCourse;
        courseTable.add({code: code, ...data});
        courseTable.add({code: newCourse.code, name:newCourse.name, description:newCourse.description});
        return newCourse.name + "saved successfuly";
    }

}

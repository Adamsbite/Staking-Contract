 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentDetails {
    struct Student {
        string name;
        uint age;
        string course;
    }

    Student public student;

    function setStudentDetails(string memory _name, uint _age, string memory _course) public {
        student = Student(_name, _age, _course);
    }

    function getStudentDetails() public view returns (string memory, uint, string memory) {
        return (student.name, student.age, student.course);
    }
     function setAndGetStudentDetails(string memory _name, uint _age, string memory _course) public returns (string memory, uint, string memory) {
        student = Student(_name, _age, _course);
        return (student.name, student.age, student.course);
    }
}

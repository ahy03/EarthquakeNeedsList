pragma solidity ^0.8.0;

// SPDX-License-Identifier: MIT


//NeedListStruct
contract EarthquakeNeedsList {
    struct Need {
        string firstName;
        string lastName;
        string requirement;
        uint amount;
        string city;
    }

    Need[] public needs;
//Adding needs on struct
    function addNeeds(
        string memory firstName,
        string memory lastName,
        string memory requirement,
        uint amount,
        string memory city
    ) public {
        needs.push(Need(firstName, lastName, requirement, amount, city));
    }
//Listing Needs By City
    function listByCity(string memory city) public view returns (string memory) {
        string memory result;
        for (uint i = 0; i < needs.length; i++) {
            if (keccak256(abi.encodePacked(needs[i].city)) == keccak256(abi.encodePacked(city))) {
                result = string(
                    abi.encodePacked(
                        result,
                        "First Name: ",
                        needs[i].firstName,
                        " Last Name: ",
                        needs[i].lastName,
                        " Requirement: ",
                        needs[i].requirement,
                        " Amount: ",
                        uint2str(needs[i].amount),
                        " City: ",
                        needs[i].city,
                        "\n"
                    )
                );
            }
        }
        return result;
    }
//Conversion from integer data type to string data type
    function uint2str(uint i) internal pure returns (string memory) {
        if (i == 0) {
            return "0";
        }
        uint j = i;
        uint length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint k = length;
        while (i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(i - i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            i /= 10;
        }
        return string(bstr);
    }
}

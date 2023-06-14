// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CovidRegistry {
    struct Person {
        string name;
        string surname;
        uint256 tcId;
        string phoneNumber;
        bool hasContractedCovid;
        string vaccineBrand;
        uint8 vaccineDose;
    }

    mapping(uint256 => Person) private persons;

    event PersonRegistered(uint256 indexed tcId, string name, string surname);
    event VaccineInfoUpdated(uint256 indexed tcId, string vaccineBrand, uint8 vaccineDose);
    event CovidStatusUpdated(uint256 indexed tcId, bool hasContractedCovid);

    function registerPerson(
        uint256 _tcId,
        string memory _name,
        string memory _surname,
        string memory _phoneNumber
    ) public {
        require(persons[_tcId].tcId == 0, "Person already registered");

        persons[_tcId] = Person({
            name: _name,
            surname: _surname,
            tcId: _tcId,
            phoneNumber: _phoneNumber,
            hasContractedCovid: false,
            vaccineBrand: "",
            vaccineDose: 0
        });

        emit PersonRegistered(_tcId, _name, _surname);
    }

    function updateVaccineInfo(
        uint256 _tcId,
        string memory _vaccineBrand,
        uint8 _vaccineDose
    ) public {
        require(persons[_tcId].tcId != 0, "Person not registered");

        persons[_tcId].vaccineBrand = _vaccineBrand;
        persons[_tcId].vaccineDose = _vaccineDose;

        emit VaccineInfoUpdated(_tcId, _vaccineBrand, _vaccineDose);
    }

    function updateCovidStatus(uint256 _tcId, bool _hasContractedCovid) public {
        require(persons[_tcId].tcId != 0, "Person not registered");

        persons[_tcId].hasContractedCovid = _hasContractedCovid;

        emit CovidStatusUpdated(_tcId, _hasContractedCovid);
    }

    function getPersonInfo(uint256 _tcId) public view returns (Person memory) {
        require(persons[_tcId].tcId != 0, "Person not registered");

        return persons[_tcId];
    }
}

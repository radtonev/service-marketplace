pragma solidity ^0.4.18;
contract ServiceExchange{
    
    address private owner;
    
    function ServiceExchange() public{
        owner = msg.sender;
    }
    
    struct Service{
        uint id;
        address employer;
        string title;
        bytes32 image;
        string company_name;
        bytes32 description;
        uint compensation;
    }
    
    struct Applicant{
        address employee;
        bytes32 name;
        bytes32 contact;
        bytes32 cv;
        uint service_address;
    }
    
    
    mapping(address => Service[]) private pendingServices;
    mapping(address => Service[]) private approvedServices;
    mapping(address => Service[]) private applicantsServicesByApplicantAddress;
    mapping(address => Applicant) private applicants;
    mapping(uint => Service) private allApprovedServicesByServiceId;
    
    mapping(uint => Applicant) private confirmedApplicationsByServiceId;
    

    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    
    function getBalance() onlyOwner public view returns(uint){
        return this.balance;
    }
    
    function submitService(string t,bytes32 i,string c,bytes32 d,uint comp) public{
        Service memory service = Service({
            id:  pendingServices[msg.sender].length,
            employer: msg.sender,
            title: t,
            image: i,
            company_name: c,
            description: d,
            compensation: comp
        });
        
        pendingServices[msg.sender].push(service);
    }
    
    function confirmServiceSubmission(address addr, uint id) onlyOwner public{
        Service memory pendingService = pendingServices[addr][id];
        delete pendingServices[addr][id];
        approvedServices[addr].push(pendingService);
        allApprovedServicesByServiceId[id] = pendingService;
    }
    
    function getMyApproovedServices() public view returns (Service[]){
        return approvedServices[msg.sender];
    }
    
    function getMyApplications() public view returns (Service[]){
      //  return approvedServices[msg.sender];
    }
  //  function getAllApprovedServices() public view returns (){
  //      return allApprovedServices;
  //  }
    
    function submitApplication(bytes32 n,bytes32 con,bytes32 c,uint servaddr) public{
        Applicant memory applicant = Applicant({
            employee: msg.sender,
            name: n,
            contact: con,
            cv: c,
            service_address: servaddr
        });
        
        applicants[msg.sender] = applicant;
        applicantsServicesByApplicantAddress[msg.sender].push(approvedServices[servaddr]);
    }
    
    function confirmApplication(Applicant applic, uint serviceId) public payable{
        Service[] memory servicesForMsgSender = approvedServices[msg.sender];
        //Require that the service id is this
        confirmedApplicationsByServiceId[serviceId] = applic;
    }
    
    function markServiceAsComplete(uint serviceId) public{
        //Payout to applicant
        Applicant memory applicant = confirmedApplicationsByServiceId[serviceId];
        //Check compensation positive
        if(!applicant.employee.send(allApprovedServicesByServiceId[serviceId].compensation)){
           throw;
        }    
    }
    
    function deleteOffer(uint serviceId){
        
    }
}
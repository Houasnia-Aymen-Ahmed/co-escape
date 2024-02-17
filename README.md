# Documentation 
## Ascent
### Overview
This mobile app aims to boost startup success in Algeria by providing consultants, marketing assistants, and finance assistants to guide idea owners through the project innovation label process and startup owners  to develop their startups .

### Getting Started
#### Prerequisites
- Ensure that the app is compatible with Android/iOS devices.

#### Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/Houasnia-Aymen-Ahmed/co-escape.git
    cd co-escape
    ```
2. Install dependencies:
    ```bash
    flutter pub get
    ```
3. Configure the app:
    - Set up necessary API keys:
      - create new **.env** and add your api keys like this: ``API_KEY=your_api_key``
      - make sure to add **.env** to the .gitignore

#### Usage
Our costumer which is the startup owners create an account with input their domain , if they have investor , BMC, Marketing plan ,finance plan and the idea owners will go with a description and title of the startup the startups will appear to the ADMINS based on 
- Consultant will receive the full idea owners list to contact with no filter ( in case if the consultant is a technical expert will filter based on domaine of expertise)
- Marketing assistant will have to choose between Startups with BMC and revise it to develop it or go directly to Startup list wit no BMC and mkt plan to create one for startup
- Finance assistant will have the ability also to choose between startups with Finance plan and startups with no finance plan 
- investor will receive the whole list of startup to invest and can filter based on domain 

# Architecture Overview:
### Modules and Components:
1. Consultant Module:
   - Responsible for handling project innovation label consultations.
   - Communicates with the database to store and retrieve
project-related information.

2. Marketing Module:
   - Creates Business Model Canvas (BMC) and marketing plans based on user inputs.
   - Stores and manages the generated documents securely.
3. Finance Module:
   - Creates finance plans by analyzing financial data provided by startups.
   - Implements security measures to protect sensitive financial information.
4. Ascent agents 
   - creates contract between costumer and service providers 
   - stores investor data 
5. Database:
   - Stores data related to startup projects, consultants, marketing plans, finance plans, and investor information.
   - Ensures data integrity and facilitates efficient retrieval for modules.
6. External Services/APIs:
   - Implements secure authentication mechanisms to access external services.

### Data Flow:
1. Consultant Module:
   - Receives project details from startups.
   - Validates and processes the information.
   - Stores relevant data in the database.
2. Marketing Module:
   - Retrieves startup information from the database.
   - creates BMC and marketing plans based on the stored data.
   - Safely stores the created documents in the database.
3. Finance Module:
   - Gathers financial data from startups.
   - Creates finance plans.
   - Connects with the database to store financial plans 
4. Startup Interaction:
   - Startups interact with the app, providing necessary details.
   - Modules process the information and update the database accordingly.
5. Security Measures:
    - Data Encryption
    - Implement encryption mechanisms to secure sensitive data in transit and at rest.
6. Authentication and Authorization:
   - Use secure authentication methods to ensure that only authorized users can access and modify data.


### Access Control:
Define access control policies to restrict access to specific modules and functionalities.
Scalability Considerations:
  1. Horizontal Scalability:
    - Design the architecture to accommodate the potential growth in the number of startups and users.
  2. Load Balancing:
    - Implement load balancing mechanisms to distribute incoming requests evenly across multiple servers.
  3. Database Sharding:
    - Consider database sharding strategies to distribute the data across multiple servers for improved performance.
Maintenance and Monitoring:
  4. Logging:
    - Implement comprehensive logging to track system activities, errors, and user interactions.
  5. Monitoring Tools:
    - Use monitoring tools to track system performance, identify bottlenecks, and ensure optimal operation.
  6. Automated Testing:
    - Integrate automated testing processes to identify and resolve issues during development.

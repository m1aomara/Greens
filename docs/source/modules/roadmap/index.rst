Roadmap
=======

.. image:: images/blankspace.png
     :align: center


.. note::
    Reference frame for the guest speakers who join our sessions

.. raw:: html

       <div id="mainapp">
           
        <div class="demo-them light">
        <timeline timeline-theme="lightblue">
          <timeline-title>September 2020</timeline-title>
          <timeline-title icon-size="large" v-for="item in journey"
                    :key="item.title" line-color="#a6ade4">

           

  <v-card class="elevation-2 custom-card-box">
                    <v-card-title class="headline">
                      {{item.title}}
                    </v-card-title>
                    <v-card-text>
                      {{item.description}}
                    </v-card-text>
                    <v-card-text>
                      {{item.duration}}
                    </v-card-text>
                  </v-card>
           
          </timeline-title>
        </timeline>
      </div>
       </div>

       <script>
         new Vue({
           el: "#mainapp",
           vuetify: new Vuetify(),
           components: {
            Timeline: window["vueCuteTimeline"]["Timeline"],
             TimelineItem: window["vueCuteTimeline"]["TimelineItem"],
             TimelineTitle: window["vueCuteTimeline"]["TimelineTitle"]
          },
           methods: {
    			showAlert: () => {
      				alert('test')
    			}
  			},
  			    data: () => ({
                  journey:[
                    {
                      title:"Intoduction to Blockchain by Prof. George Petrovic",
                      description:" Course Highlights - Blockchain Evolution, Inside Bitcoin's Blockchain, Consensus Mechanisms, Blockchain: Components, Layers, Ecosystem, Value & Benefits\n" +
                          "Public, Private & Consortium Blockchain, Intro to Ethereum & Smart Contract, Intro to Hyperledger Fabric & Sawtooth, Real-life usecase discussion\n",
                      bulletPoint:"BCDV 1001",
                      duration : "Duration - 8 sessions 4 hour each"
                    },
                    {
                      title:"Full Stack Development-I by Prof. Mike Denton ",
                      description:"Course Highlights - Intro to Full StackDevelopment, Introduction and Fundamentals of HTML & CSS & Intro to JavaScript with regular hands-on lab sessions" ,
                      bulletPoint:"BCDV 1006 ",
                      duration : "Duration - 12 sessions 4 hour each"
                    },
                    {
                      title:"Law & Regulations by Prof. Nelia Teixeira",
                      description:" Course Highlights - DAO & Business Structures, Blockchain Start-up Law, Intellectual Property & NDA ,Open Source Licenses,Patents" +
                      "AML Legislation, PCMLTFA Legislation, AML, Privacy Laws, Canadian Charter of Rights and Freedoms, right to be forgotten : GDPR ",
                      bulletPoint:"BCDV 1004 ",
                      duration : "Duration - 4 sessions 4 hour each",
                      submission : "Final submission - https://tenderbullet-whitepaper.osive.com/"
                    },
                    {
                      title:"Full Stack Development-II by Prof. Mike Denton",
                      description:"Course Highlights - JavaScript Fundamentals, Error Handling, Arrays, DOM Manipulations & Events, RESTful API and JSON,  ES6 Fundamentals with regular hands-on lab sessions ",
                      bulletPoint:"BCDV 1007 ",
                      duration : "Duration - 12 sessions 4 hour each"
                    },
                    {
                      title:"Introduction To Smart Contracts by Prof. Dhruvin Parikh",
                      description:" Course Highlights - Structure of Smart COntract, Introduction to Solidity, Building decentralised application with Ethereum and Javascript using web3js, ethersjs and Ganache",
                      bulletPoint:"BCDV 1016 ",
                      duration : "Duration - 4 sessions 4 hour each"
                    },
                    {
                      title:"Full Stack Development-III by Prof. Mike Denton",
                      description:" Course Highlights - Node.js - Fundamentals, Networking, Asynchronous Code, Express.js - Routing,Restful API, MongoDB - Fundamentals & Integrating Mongoose with Node, Node Core Concepts & Node Cluster with regular hands-on lab sessions",
                      bulletPoint:"BCDV 1008 ",
                      duration : "Duration -  9 sessions 4 hour each"
                    },
                    { title:"Industry Applications by Prof. Marc Lijour & Prof. Alim Khamisa ",
                      description:" Course Highlights - The nature of money and the business case for blockchain, Introduction to blockchain applications in industry, Features of financial management" +
                          "Token fondamentals for business applications, Ecosystems" + "Blockchain applications in enterprise. " +
                          "Whitepapers/Case Studies shared - Maker DAO, Dai, Centre, USDC, Kin, Filecoin, DENT, Quorum, Baseline Protocol",
                      bulletPoint:"BCDV 1005 ",
                      duration : "Duration -  6 sessions 4 hour each"  }
                  ]
                })
         });
       </script>

       <style>
       ul, li { ist-style-type: none; }

       .custom-card-box{
        width:60%;
       }
  .append {
    font-size: .8em;
    margin-top: 3px;
    color: #646C7C;
  }
  a {
    color: #bf6dcf;
    font-weight: bold;
    text-decoration: none;
  }
  .icon-heart {
    width: 20px;
  }
  .demo {
    display: grid;
    grid-template-columns: repeat(2, 50%);
    grid-gap: 1rem;
  }
  .demo-theme.dark {
    background: #3a3939;
  }
</style>




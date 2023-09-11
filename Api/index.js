const express = require("express");
const cors = require("cors");
const mymod = require('./config/config');
const RequestDatabase = mymod.RequestDatabase;
const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
const apiport = 8080;

try {

  // app.post("/add", (req, res) => {
  //   try {
  //     if (!req.body) {
  //       return res.status(400).send("Request body is missing");
  //     } else {
  //       let sympo_users= req.body.user.toString().split(";");
  //       let sympo_qr= req.body.qr.toString().split(";");
        
  //         for (let j = 0; j < sympo_users?.length ?? 0; j++) {
            
  //           RequestDatabase.query(
  //             "INSERT INTO sympo (TeamId, StudentName, Qrcode, Morning, AfterNoon) VALUES ('" + req.body.teamid + "','" + sympo_users[j] + "','" + sympo_qr[j] + "','True','True')",
  //             (err, result) => {
  //               if (err) {
  //                 console.log(err);
  //                  res.status(500).send("Error");
  //               } else {
  //                console.log("OK");
  //               }
  //             }
  //           );
  //         }
  

  //       res.send("success");
  //     }
  //   } catch (error) {
  //     res.send(error.message);
  //   }
 
   
  // });



  app.post("/addstudent", (req, res) => {
    if (!req.body) {
      return res.status(400).send("Request body is missing");
    }
    RequestDatabase.query("select * from sympo where  TeamID='"+req.body.teamid+"'",(err,result)=>{
      if(err){
        console.log(err);
      }
      else{
       if( result["recordset"].length!=0){
        res.send("Already Exist");
       }
       else{
        let sympo_users= req.body.user.toString().split(";");
        let sympo_qr= req.body.qr.toString().split(";");
        
          for (let j = 0; j < sympo_users?.length ?? 0; j++) {
            RequestDatabase.query(
              "INSERT INTO sympo (TeamId, StudentName, Qrcode, Morning, AfterNoon) VALUES ('" + req.body.teamid + "','" + sympo_users[j] + "','" + sympo_qr[j] + "','True','True')",
              (err, result) => {
                if (err) {
                  console.log(err);
                   res.status(500).send("Error");
                } else {
                 console.log("OK");
                }
              }
            );
          }
        res.send("success");
       }
      }
    })
      
  });

  app.get('/Get', (req, res) => {
    RequestDatabase.query("select * from sympo").then(function (recordset) {
      res.send(recordset)
    })
  });

  app.listen(apiport, () => {
    console.log("Backend server is running" + " " + apiport);
  });
} catch (error) {
  console.log("Throw Error:" + error);
}
process.on("uncaughtException", (err, origin) => {
  //code to log the errors
  console.log(`Caught exception: ${err}\n` + `Exception origin: ${origin}`);
});

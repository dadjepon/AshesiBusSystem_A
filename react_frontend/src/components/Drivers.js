import React, { useEffect, useState } from 'react';
import { Table } from 'react-bootstrap';
import { getDrivers } from '../services/DriverService';
import "../App.css";

const Drivers = () => {
  const [drivers, setDrivers] = useState([]);

  useEffect(() => {
   let mounted = true;
   getDrivers()
     .then(data => {
       if(mounted) {
         console.log('Data returned by getDrivers():', data);
         setDrivers(data)
       }
     })
     .catch(error => {
      console.error('Error fetching drivers:', error);
     });


   return () => mounted = false;
 }, [])

  return(
   <div className="container-fluid side-container">
   <div className="row side-row" >
    <p id="before-table"></p>
        <Table striped bordered hover className="react-bootstrap-table" id="dataTable">
        <thead>
            <tr>
            <th>Driver_ID</th>
            <th>Driver Ashesi_ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Phone Number</th>
            </tr>
        </thead>
        <tbody>
            {drivers.map((dri) =>
            <tr key={dri.id}>
                <td>{dri.driver_id}</td>
                <td>{dri.driver_ashesi_id}</td>
                <td>{dri.fname}</td>
                <td>{dri.lname}</td>
                <td>{dri.phone_number}</td>
            </tr>)}
        </tbody>
    </Table>
    </div>
  </div>
  );
};

export default Drivers;
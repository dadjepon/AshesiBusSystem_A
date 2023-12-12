import React, { useEffect, useState } from 'react';
import { Table } from 'react-bootstrap';
import { getVehicles } from '../services/VehicleService';
import "../App.css";

const Vehicles = () => {
  const [vehicles, setVehicles] = useState([]);

  useEffect(() => {
   let mounted = true;
   getVehicles()
     .then(data => {
       if(mounted) {
         setVehicles(data)
       }
     })
   return () => mounted = false;
 }, [])

  return(
   <div className="container-fluid side-container">
   <div className="row side-row" >
    <p id="before-table"></p>
        <Table striped bordered hover className="react-bootstrap-table" id="dataTable">
        <thead>
            <tr>
            <th>Vehicle_ID</th>
            <th>Vehicle Name</th>
            <th>License Number</th>
            <th>Model</th>
            <th>is_available</th>
            </tr>
        </thead>
        <tbody>
            {vehicles.map((veh) =>
            <tr key={veh.id}>
                <td>{veh.vehicle_id}</td>
                <td>{veh.vehicle_name}</td>
                <td>{veh.license_no}</td>
                <td>{veh.model}</td>
                <td>{veh.is_available}</td>
            </tr>)}
        </tbody>
    </Table>
    </div>
  </div>
  );
};

export default Vehicles;
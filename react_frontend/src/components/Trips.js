import React, { useEffect, useState } from 'react';
import { Table } from 'react-bootstrap';
import { getTrips } from '../services/TripService';
import "../App.css";

const Trips = () => {
  const [trips, setTrips] = useState([]);

  useEffect(() => {
   let mounted = true;
   getTrips()
     .then(data => {
       if(mounted) {
         setTrips(data)
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
            <th>Trip_ID</th>
            <th>Trip Name</th>
            <th>Trip_Start_Time</th>
            <th>Trip_End_Time</th>
            </tr>
        </thead>
        <tbody>
            {trips.map((tri) =>
            <tr key={tri.id}>
                <td>{tri.trip_id}</td>
                <td>{tri.trip_name}</td>
                <td>{tri.trip_start_time}</td>
                <td>{tri.trip_start_time}</td>
            </tr>)}
        </tbody>
    </Table>
    </div>
  </div>
  );
};

export default Trips;
import React, { useEffect, useState } from 'react';
import { Table } from 'react-bootstrap';
import { getLicenses } from '../services/LicenseService';
import "../App.css";

const Licenses = () => {
  const [licenses, setLicenses] = useState([]);

  useEffect(() => {
   let mounted = true;
   getLicenses()
     .then(data => {
       if(mounted) {
         setLicenses(data)
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
            <th>License_ID</th>
            <th>Driver ID</th>
            <th>License Number</th>
            <th>Issue Date</th>
            <th>Expiry Date</th>
            <th>is_verified</th>
            </tr>
        </thead>
        <tbody>
            {licenses.map((lic) =>
            <tr key={lic.id}>
                <td>{lic.license_id}</td>
                <td>{lic.driver}</td>
                <td>{lic.license_number}</td>
                <td>{lic.issue_date}</td>
                <td>{lic.expiry_date}</td>
                <td>{lic.is_verified}</td>
            </tr>)}
        </tbody>
    </Table>
    </div>
  </div>
  );
};

export default Licenses;
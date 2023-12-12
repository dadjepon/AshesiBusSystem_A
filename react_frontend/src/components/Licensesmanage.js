import React,{ useEffect, useState }from 'react';
import {Table} from 'react-bootstrap';

import {Button,ButtonToolbar } from 'react-bootstrap';
import { FaEdit } from 'react-icons/fa';
import { RiDeleteBin5Line } from 'react-icons/ri';
import AddLicenseModal from "./AddLicenseModal";
import UpdateLicenseModal from "./UpdateLicenseModal";
import { getLicenses, deleteLicense } from '../services/LicenseService';


const Licensesmanage = () => {
    const [licenses, setLicenses] = useState([]);
    const [addModalShow, setAddModalShow] = useState(false);
    const [editModalShow, setEditModalShow] = useState(false);
    const [editLicense, setEditLicense] = useState([]);
    const [isUpdated, setIsUpdated] = useState(false);

    useEffect(() => {
       let mounted = true;
       if(licenses.length && !isUpdated) {
        return;
        }
       getLicenses()
         .then(data => {
           if(mounted) {
             setLicenses(data);
           }
         })
       return () => {
          mounted = false;
          setIsUpdated(false);
       }
     }, [isUpdated, licenses])

    const handleUpdate = (e, lic) => {
        e.preventDefault();
        setEditModalShow(true);
        setEditLicense(lic);
    };

    const handleAdd = (e) => {
        e.preventDefault();
        setAddModalShow(true);
    };

    const handleDelete = (e, license_id) => {
        if(window.confirm('Are you sure ?')){
            e.preventDefault();
            deleteLicense(license_id)
            .then((result)=>{
                alert(result);
                setIsUpdated(true);
            },
            (error)=>{
                alert("Failed to Delete License");
            })
        }
    };

    let AddModelClose=()=>setAddModalShow(false);
    let EditModelClose=()=>setEditModalShow(false);
    return(
        <div className="container-fluid side-container">
        <div className="row side-row" >
        <p id="manage"></p>
            <Table striped bordered hover className="react-bootstrap-table" id="dataTable">
                <thead>
                <tr>
                  <th>License_ID</th>
                  <th>Driver ID</th>
                  <th>License Number</th>
                  <th>Issue Date</th>
                  <th>Expiry Date</th>
                  <th>is_verified</th>
                  <th>Action</th>
                </tr>
                </thead>
                <tbody>
                  { licenses.map((lic) =>

                  <tr key={lic.id}>
                  <td>{lic.license_id}</td>
                  <td>{lic.driver}</td>
                  <td>{lic.license_number}</td>
                  <td>{lic.issue_date}</td>
                  <td>{lic.expiry_date}</td>
                  <td>{lic.is_verified}</td>
                  <td>

                  <Button className="mr-2" variant="danger"
                    onClick={event => handleDelete(event,lic.license_id)}>
                        <RiDeleteBin5Line />
                  </Button>
                  <span>&nbsp;&nbsp;&nbsp;</span>
                  <Button className="mr-2"
                    onClick={event => handleUpdate(event,lic)}>
                        <FaEdit />
                  </Button>
                  <UpdateLicenseModal show={editModalShow} license={editLicense} setUpdated={setIsUpdated}
                              onHide={EditModelClose}></UpdateLicenseModal>
                </td>
                </tr>)}
              </tbody>
            </Table>
            <ButtonToolbar>
                <Button variant="primary" onClick={handleAdd}>
                Add License
                </Button>
                <AddLicenseModal show={addModalShow} setUpdated={setIsUpdated}
                onHide={AddModelClose}></AddLicenseModal>
            </ButtonToolbar>
        </div>
        </div>
    );
};

export default Licensesmanage;
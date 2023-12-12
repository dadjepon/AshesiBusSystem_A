import React,{ useEffect, useState }from 'react';
import {Table} from 'react-bootstrap';

import {Button,ButtonToolbar } from 'react-bootstrap';
import { FaEdit } from 'react-icons/fa';
import { RiDeleteBin5Line } from 'react-icons/ri';
import AddDriverModal from "./AddDriverModal";
import UpdateDriverModal from "./UpdateDriverModal";
import { getDrivers, deleteDriver } from '../services/DriverService';


const Driversmanage = () => {
    const [drivers, setDrivers] = useState([]);
    const [addModalShow, setAddModalShow] = useState(false);
    const [editModalShow, setEditModalShow] = useState(false);
    const [editDriver, setEditDriver] = useState([]);
    const [isUpdated, setIsUpdated] = useState(false);

    useEffect(() => {
       let mounted = true;
       if(drivers.length && !isUpdated) {
        return;
        }
       getDrivers()
         .then(data => {
           if(mounted) {
             setDrivers(data);
           }
         })
       return () => {
          mounted = false;
          setIsUpdated(false);
       }
     }, [isUpdated, drivers])

    const handleUpdate = (e, dri) => {
        e.preventDefault();
        setEditModalShow(true);
        setEditDriver(dri);
    };

    const handleAdd = (e) => {
        e.preventDefault();
        setAddModalShow(true);
    };

    const handleDelete = (e, driver_id) => {
        if(window.confirm('Are you sure ?')){
            e.preventDefault();
            deleteDriver(driver_id)
            .then((result)=>{
                alert(result);
                setIsUpdated(true);
            },
            (error)=>{
                alert("Failed to Delete Driver");
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
                  <th>Driver_ID</th>
                  <th>Driver Ashesi_ID</th>
                  <th>First Name</th>
                  <th>Last Name</th>
                  <th>Phone Number</th>
                  <th>Action</th>
                </tr>
                </thead>
                <tbody>
                  { drivers.map((dri) =>

                  <tr key={dri.id}>
                  <td>{dri.driver_id}</td>
                  <td>{dri.driver_ashesi_id}</td>
                  <td>{dri.fname}</td>
                  <td>{dri.lname}</td>
                  <td>{dri.phone_number}</td>
                  <td>

                  <Button className="mr-2" variant="danger"
                    onClick={event => handleDelete(event,dri.driver_id)}>
                        <RiDeleteBin5Line />
                  </Button>
                  <span>&nbsp;&nbsp;&nbsp;</span>
                  <Button className="mr-2"
                    onClick={event => handleUpdate(event,dri)}>
                        <FaEdit />
                  </Button>
                  <UpdateDriverModal show={editModalShow} driver={editDriver} setUpdated={setIsUpdated}
                              onHide={EditModelClose}></UpdateDriverModal>
                </td>
                </tr>)}
              </tbody>
            </Table>
            <ButtonToolbar>
                <Button variant="primary" onClick={handleAdd}>
                Add Driver
                </Button>
                <AddDriverModal show={addModalShow} setUpdated={setIsUpdated}
                onHide={AddModelClose}></AddDriverModal>
            </ButtonToolbar>
        </div>
        </div>
    );
};

export default Driversmanage;
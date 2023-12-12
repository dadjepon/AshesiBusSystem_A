import React,{ useEffect, useState }from 'react';
import {Table} from 'react-bootstrap';

import {Button,ButtonToolbar } from 'react-bootstrap';
import { FaEdit } from 'react-icons/fa';
import { RiDeleteBin5Line } from 'react-icons/ri';
import AddVehicleModal from "./AddVehicleModal";
import UpdateVehicleModal from "./UpdateVehicleModal";
import { getVehicles, deleteVehicle } from '../services/VehicleService';


const Vehiclesmanage = () => {
    const [vehicles, setVehicles] = useState([]);
    const [addModalShow, setAddModalShow] = useState(false);
    const [editModalShow, setEditModalShow] = useState(false);
    const [editVehicle, setEditVehicle] = useState([]);
    const [isUpdated, setIsUpdated] = useState(false);

    useEffect(() => {
       let mounted = true;
       if(vehicles.length && !isUpdated) {
        return;
        }
       getVehicles()
         .then(data => {
           if(mounted) {
             setVehicles(data);
           }
         })
       return () => {
          mounted = false;
          setIsUpdated(false);
       }
     }, [isUpdated, vehicles])

    const handleUpdate = (e, veh) => {
        e.preventDefault();
        setEditModalShow(true);
        setEditVehicle(veh);
    };

    const handleAdd = (e) => {
        e.preventDefault();
        setAddModalShow(true);
    };

    const handleDelete = (e, vehicle_id) => {
        if(window.confirm('Are you sure ?')){
            e.preventDefault();
            deleteVehicle(vehicle_id)
            .then((result)=>{
                alert(result);
                setIsUpdated(true);
            },
            (error)=>{
                alert("Failed to Delete Vehicle");
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
                  <th>Vehicle_ID</th>
                  <th>Vehicle Name</th>
                  <th>License Number</th>
                  <th>Model</th>
                  <th>is_available</th>
                  <th>Action</th>
                </tr>
                </thead>
                <tbody>
                  { vehicles.map((veh) =>

                  <tr key={veh.id}>
                  <td>{veh.vehicle_id}</td>
                  <td>{veh.vehicle_name}</td>
                  <td>{veh.license_no}</td>
                  <td>{veh.model}</td>
                  <td>{veh.is_available}</td>
                  <td>

                  <Button className="mr-2" variant="danger"
                    onClick={event => handleDelete(event,veh.vehicle_id)}>
                        <RiDeleteBin5Line />
                  </Button>
                  <span>&nbsp;&nbsp;&nbsp;</span>
                  <Button className="mr-2"
                    onClick={event => handleUpdate(event,veh)}>
                        <FaEdit />
                  </Button>
                  <UpdateVehicleModal show={editModalShow} vehicle={editVehicle} setUpdated={setIsUpdated}
                              onHide={EditModelClose}></UpdateVehicleModal>
                </td>
                </tr>)}
              </tbody>
            </Table>
            <ButtonToolbar>
                <Button variant="primary" onClick={handleAdd}>
                Add Vehicle
                </Button>
                <AddVehicleModal show={addModalShow} setUpdated={setIsUpdated}
                onHide={AddModelClose}></AddVehicleModal>
            </ButtonToolbar>
        </div>
        </div>
    );
};

export default Vehiclesmanage;
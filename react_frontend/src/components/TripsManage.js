import React,{ useEffect, useState }from 'react';
import {Table} from 'react-bootstrap';

import {Button,ButtonToolbar } from 'react-bootstrap';
import { FaEdit } from 'react-icons/fa';
import { RiDeleteBin5Line } from 'react-icons/ri';
import AddTripModal from "./AddTripModal";
import UpdateTripModal from "./UpdateTripModal";
import { getTrips, deleteTrip } from '../services/TripService';


const Tripsmanage = () => {
    const [trips, setTrips] = useState([]);
    const [addModalShow, setAddModalShow] = useState(false);
    const [editModalShow, setEditModalShow] = useState(false);
    const [editTrip, setEditTrip] = useState([]);
    const [isUpdated, setIsUpdated] = useState(false);

    useEffect(() => {
       let mounted = true;
       if(trips.length && !isUpdated) {
        return;
        }
       getTrips()
         .then(data => {
           if(mounted) {
             setTrips(data);
           }
         })
       return () => {
          mounted = false;
          setIsUpdated(false);
       }
     }, [isUpdated, trips])

    const handleUpdate = (e, tri) => {
        e.preventDefault();
        setEditModalShow(true);
        setEditTrip(tri);
    };

    const handleAdd = (e) => {
        e.preventDefault();
        setAddModalShow(true);
    };

    const handleDelete = (e, trip_id) => {
        if(window.confirm('Are you sure ?')){
            e.preventDefault();
            deleteTrip(trip_id)
            .then((result)=>{
                alert(result);
                setIsUpdated(true);
            },
            (error)=>{
                alert("Failed to Delete Trip");
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
                  <th>Trip_ID</th>
                  <th>Trip Name</th>
                  <th>Trip_Start_Time</th>
                  <th>Trip_End_Time</th>
                  <th>Action</th>
                </tr>
                </thead>
                <tbody>
                  { trips.map((tri) =>

                  <tr key={tri.id}>
                  <td>{tri.trip_id}</td>
                  <td>{tri.trip_name}</td>
                  <td>{tri.trip_start_time}</td>
                  <td>{tri.trip_end_time}</td>
                  <td>

                  <Button className="mr-2" variant="danger"
                    onClick={event => handleDelete(event,tri.trip_id)}>
                        <RiDeleteBin5Line />
                  </Button>
                  <span>&nbsp;&nbsp;&nbsp;</span>
                  <Button className="mr-2"
                    onClick={event => handleUpdate(event,tri)}>
                        <FaEdit />
                  </Button>
                  <UpdateTripModal show={editModalShow} trip={editTrip} setUpdated={setIsUpdated}
                              onHide={EditModelClose}></UpdateTripModal>
                </td>
                </tr>)}
              </tbody>
            </Table>
            <ButtonToolbar>
                <Button variant="primary" onClick={handleAdd}>
                Add Trip
                </Button>
                <AddTripModal show={addModalShow} setUpdated={setIsUpdated}
                onHide={AddModelClose}></AddTripModal>
            </ButtonToolbar>
        </div>
        </div>
    );
};

export default Tripsmanage;
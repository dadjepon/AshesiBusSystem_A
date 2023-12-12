import React,{Component} from 'react';
import {Modal, Col, Row, Form, Button} from 'react-bootstrap';
import {FormControl, FormGroup, FormLabel} from 'react-bootstrap';
import { updateVehicle } from '../services/VehicleService';



const UpdateVehicleModal = (props) => {

    const handleSubmit = (e) => {
        e.preventDefault();
        updateVehicle(props.vehicle.vehicle_id, e.target)
        .then((result)=>{
            alert(result);
            props.setUpdated(true);
        },
        (error)=>{
            alert("Failed to Update Vehicle");
        })
    };

    return(
        <div className="container">

            <Modal
                {...props}
                size="lg"
                aria-labelledby="contained-modal-title-vcenter"
                centered >

                <Modal.Header closeButton>
                    <Modal.Title id="contained-modal-title-vcenter">
                        Update Vehicle Information
                    </Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Row>
                        <Col sm={6}>
                            <Form onSubmit={handleSubmit}>
                                <Form.Group controlId="vehicle_name">
                                    <Form.Label>Vehicle Name</Form.Label>
                                    <Form.Control type="text" name="vehicle_name" required defaultValue={props.vehicle.vehicle_name} placeholder="" />
                            </Form.Group>

                            <Form.Group controlId="license_no">
                                    <Form.Label>License No</Form.Label>
                                    <Form.Control type="text" name="license_no" required defaultValue={props.vehicle.license_no} placeholder="" />
                            </Form.Group>
                            <Form.Group controlId="model">
                                    <Form.Label>Model</Form.Label>
                                    <Form.Control type="text" name="model" required defaultValue={props.vehicle.model} placeholder="" />
                            </Form.Group>
                            <Form.Group controlId="is_available">
                                    <Form.Label>is_available</Form.Label>
                                    <Form.Control type="text" name="is_available" required defaultValue={props.vehicle.is_available} placeholder="" />
                            </Form.Group>
                            <Form.Group>
                                <p></p>
                                <Button variant="primary" type="submit">
                                    Submit
                                </Button>
                            </Form.Group>
                            </Form>
                        </Col>
                    </Row>
                </Modal.Body>
                <Modal.Footer>
                <Button variant="danger" type="submit" onClick={props.onHide}>
                        Close
                </Button>

                </Modal.Footer>
            </Modal>
        </div>
    );
};


export default UpdateVehicleModal;


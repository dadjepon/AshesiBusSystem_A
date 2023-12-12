import React from 'react';
import {Modal, Col, Row, Form, Button} from 'react-bootstrap';
import {FormControl, FormGroup, FormLabel} from 'react-bootstrap';
import { addVehicle } from '../services/VehicleService';


const AddVehicleModal = (props) => {

    const handleSubmit = (e) => {
        e.preventDefault();
        addVehicle(e.target)
        .then((result)=>{
            alert(result);
            props.setUpdated(true);
        },
        (error)=>{
            alert("Failed to Add Vehicle");
        })
    }

    return(
        <div className="container">

            <Modal
                {...props}
                size="lg"
                aria-labelledby="contained-modal-title-vcenter"
                centered >

                <Modal.Header closeButton>
                    <Modal.Title id="contained-modal-title-vcenter">
                        Fill In Vehicle Information
                    </Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Row>
                        <Col sm={6}>
                            <Form onSubmit={handleSubmit}>
                                <Form.Group controlId="vehicle_name">
                                    <Form.Label>Vehicle Name</Form.Label>
                                    <Form.Control type="text" name="vehicle_name" required placeholder="" />
                            </Form.Group>
                            <Form.Group controlId="license_no">
                                    <Form.Label>License Number</Form.Label>
                                    <Form.Control type="text" name="license_no" required placeholder="" />
                            </Form.Group>
                            <Form.Group controlId="model">
                                    <Form.Label>Model</Form.Label>
                                    <Form.Control type="text" name="model" required placeholder="" />
                            </Form.Group>
                            <Form.Group controlId="is_available">
                                    <Form.Label>is_available</Form.Label>
                                    <Form.Control type="text" name="is_available" required placeholder="" />
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

export default AddVehicleModal;
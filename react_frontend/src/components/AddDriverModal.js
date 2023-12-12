import React from 'react';
import {Modal, Col, Row, Form, Button} from 'react-bootstrap';
import {FormControl, FormGroup, FormLabel} from 'react-bootstrap';
import { addDriver } from '../services/DriverService';


const AddDriverModal = (props) => {

    const handleSubmit = (e) => {
        e.preventDefault();
        addDriver(e.target)
        .then((result)=>{
            alert(result);
            props.setUpdated(true);
        },
        (error)=>{
            alert("Failed to Add Driver");
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
                        Fill In Driver Information
                    </Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Row>
                        <Col sm={6}>
                            <Form onSubmit={handleSubmit}>
                                <Form.Group controlId="driver_ashesi_id">
                                    <Form.Label>Driver Ashesi ID</Form.Label>
                                    <Form.Control type="text" name="driver_ashesi_id" required placeholder="" />
                            </Form.Group>
                            <Form.Group controlId="fname">
                                    <Form.Label>First Name</Form.Label>
                                    <Form.Control type="text" name="fname" required placeholder="" />
                            </Form.Group>
                            <Form.Group controlId="lname">
                                    <Form.Label>Last Name</Form.Label>
                                    <Form.Control type="text" name="lname" required placeholder="" />
                            </Form.Group>
                            <Form.Group controlId="phone_number">
                                    <Form.Label>Phone Number</Form.Label>
                                    <Form.Control type="text" name="phone_number" required placeholder="" />
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

export default AddDriverModal;
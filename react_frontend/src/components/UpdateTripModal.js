import React,{Component} from 'react';
import {Modal, Col, Row, Form, Button} from 'react-bootstrap';
import {FormControl, FormGroup, FormLabel} from 'react-bootstrap';
import { updateTrip } from '../services/TripService';



const UpdateTripModal = (props) => {

    const handleSubmit = (e) => {
        e.preventDefault();
        updateTrip(props.trip.trip_id, e.target)
        .then((result)=>{
            alert(result);
            props.setUpdated(true);
        },
        (error)=>{
            alert("Failed to Update Trip");
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
                        Update Trip Information
                    </Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Row>
                        <Col sm={6}>
                            <Form onSubmit={handleSubmit}>
                                <Form.Group controlId="trip_name">
                                    <Form.Label>Trip Name</Form.Label>
                                    <Form.Control type="text" name="trip_name" required defaultValue={props.trip.trip_name} placeholder="" />
                            </Form.Group>

                            <Form.Group controlId="trip_start_time">
                                    <Form.Label>Trip_Start_Time</Form.Label>
                                    <Form.Control type="text" name="trip_name" required defaultValue={props.trip.trip_name} placeholder="" />
                            </Form.Group>
                            <Form.Group controlId="trip_start_time">
                                    <Form.Label>trip_start_time</Form.Label>
                                    <Form.Control type="text" name="trip_start_time" required defaultValue={props.trip.trip_start_time} placeholder="" />
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


export default UpdateTripModal;


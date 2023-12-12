import React,{Component} from 'react';
import {Modal, Col, Row, Form, Button} from 'react-bootstrap';
import {FormControl, FormGroup, FormLabel} from 'react-bootstrap';
import { updateLicense } from '../services/LicenseService';



const UpdateLicenseModal = (props) => {

    const handleSubmit = (e) => {
        e.preventDefault();
        updateLicense(props.license.license_id, e.target)
        .then((result)=>{
            alert(result);
            props.setUpdated(true);
        },
        (error)=>{
            alert("Failed to Update License");
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
                        Update License Information
                    </Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Row>
                        <Col sm={6}>
                            <Form onSubmit={handleSubmit}>
                                <Form.Group controlId="driver">
                                    <Form.Label>Driver ID</Form.Label>
                                    <Form.Control type="text" name="driver" required defaultValue={props.license.driver} placeholder="" />
                            </Form.Group>

                            <Form.Group controlId="license_number">
                                    <Form.Label>License Number</Form.Label>
                                    <Form.Control type="text" name="license_number" required defaultValue={props.license.license_number} placeholder="" />
                            </Form.Group>
                            <Form.Group controlId="issue_date">
                                    <Form.Label>Issue Date</Form.Label>
                                    <Form.Control type="text" name="issue_date" required defaultValue={props.license.issue_date} placeholder="" />
                            </Form.Group>
                            <Form.Group controlId="expiry_date">
                                    <Form.Label>Expiry Date</Form.Label>
                                    <Form.Control type="text" name="expiry_date" required defaultValue={props.license.expiry_date} placeholder="" />
                            </Form.Group>
                            <Form.Group controlId="is_verified">
                                    <Form.Label>is_verified</Form.Label>
                                    <Form.Control type="text" name="is_verified" required defaultValue={props.license.is_verified} placeholder="" />
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


export default UpdateLicenseModal;


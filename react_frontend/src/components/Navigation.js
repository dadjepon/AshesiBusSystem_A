import React from 'react';
import {Navbar,Nav} from 'react-bootstrap';
import logo from '../static/logo.png'
import "../App.css";
import {NavLink} from 'react-router-dom';
import {
  CDBSidebar,
  CDBSidebarContent,
  CDBSidebarFooter,
  CDBSidebarHeader,
  CDBSidebarMenu,
  CDBSidebarMenuItem,
} from 'cdbreact';


const Navigation = () => {
  return (
    <div>
    <Navbar bg="dark" variant="dark" expand="lg" id="my-nav">
        <Navbar.Brand className="app-logo" href="/">
            {/*<img
              src={logo}
              width="40"
              height="50"
              className="d-inline-block align-center"
              alt="React Bootstrap logo"
  />{' '}*/}
            Ashesi Bus Management System
        </Navbar.Brand>
    </Navbar>
    <div className='sidebar'>
<CDBSidebar textColor="#333" backgroundColor="#f0f0f0">
    <CDBSidebarHeader prefix={<i className="fa fa-bars" />}>
      Navigation
    </CDBSidebarHeader>
    <CDBSidebarContent>
      <CDBSidebarMenu>
        <NavLink exact to="/" activeClassName="activeClicked">
          <CDBSidebarMenuItem icon="home">Home</CDBSidebarMenuItem>
        </NavLink>
        <NavLink exact to="/drivers" activeClassName="activeClicked">
          <CDBSidebarMenuItem icon="list">Drivers List</CDBSidebarMenuItem>
        </NavLink>
        <NavLink exact to="/managed" activeClassName="activeClicked">
          <CDBSidebarMenuItem icon="user">Manage Drivers</CDBSidebarMenuItem>
        </NavLink>
        <NavLink exact to="/vehicles" activeClassName="activeClicked">
          <CDBSidebarMenuItem icon="list">Vehicles List</CDBSidebarMenuItem>
        </NavLink>
        <NavLink exact to="/managev" activeClassName="activeClicked">
          <CDBSidebarMenuItem icon="user">Manage Vehicles</CDBSidebarMenuItem>
        </NavLink>
        <NavLink exact to="/trips" activeClassName="activeClicked">
          <CDBSidebarMenuItem icon="list">Trips List</CDBSidebarMenuItem>
        </NavLink>
        <NavLink exact to="/managet" activeClassName="activeClicked">
          <CDBSidebarMenuItem icon="user">Manage Trips</CDBSidebarMenuItem>
        </NavLink>
        <NavLink exact to="/licenses" activeClassName="activeClicked">
          <CDBSidebarMenuItem icon="list">License List</CDBSidebarMenuItem>
        </NavLink>
        <NavLink exact to="/managel" activeClassName="activeClicked">
          <CDBSidebarMenuItem icon="user">Manage License</CDBSidebarMenuItem>
        </NavLink>
      </CDBSidebarMenu>
    </CDBSidebarContent>
  </CDBSidebar>
</div>
    </div>
  );
};

export default Navigation;
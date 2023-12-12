import React from "react";
import './Login.css'
import { useHistory } from 'react-router-dom';

const Login = () => {
    return(
        <div className="login-container">
            <form className="login-form">
                <h2>Login</h2>
                <p>Enter your email and password to enrich the Ashesi bus experience.</p>

                <hr />

                {/* Your logo goes here */}
                <div className="logo">
                <img src="your-logo.png" alt="Logo" />
                </div>

                <label htmlFor="email">Email address:</label>
                <input type="email" id="email" name="email" required />

                <label htmlFor="password">Password:</label>
                <input type="password" id="password" name="password" required />

                <button type="submit">Login</button>

                <p>Don't have an account? Sign up</p>
            </form>
        </div>
    )
}

export default Login


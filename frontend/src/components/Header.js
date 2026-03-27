import React, { useContext } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import AuthContext from '../context/AuthContext';
import '../styles/Header.css';

const Header = ({ theme, onThemeToggle }) => {
    const { user, logout } = useContext(AuthContext);
    const navigate = useNavigate();

    const handleLogout = () => {
        logout();
        navigate('/');
    };

    return (
        <header className="header">
            <div className="header-container">
                <Link to="/" className="logo">
                    📝 Blog Website
                </Link>
                <nav className="nav">
                    <ul>
                        <li><Link to="/">Home</Link></li>
                        {user ? (
                            <>
                                {(user.role === 'author' || user.role === 'admin') && (
                                    <>
                                        <li><Link to="/create">Write Blog</Link></li>
                                        <li><Link to="/post">Post Blog</Link></li>
                                    </>
                                )}
                                {user.role === 'admin' && (
                                    <li><Link to="/admin">Admin</Link></li>
                                )}
                                <li><span className="user-info">Hi, {user.username}</span></li>
                                <li><button onClick={handleLogout} className="logout-btn">Logout</button></li>
                            </>
                        ) : (
                            <>
                                <li><Link to="/login">Login</Link></li>
                                <li><Link to="/register">Register</Link></li>
                            </>
                        )}
                        <li>
                            <button onClick={onThemeToggle} className="theme-toggle" aria-label="Toggle dark mode">
                                {theme === 'dark' ? '☀️ Light' : '🌙 Dark'}
                            </button>
                        </li>
                    </ul>
                </nav>
            </div>
        </header>
    );
};

export default Header;

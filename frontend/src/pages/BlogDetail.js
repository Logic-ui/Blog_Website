import React, { useState, useEffect, useContext } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { blogService } from '../services/api';
import { userService } from '../services/api';
import AuthContext from '../context/AuthContext';
import '../styles/Blog.css';

const BlogDetail = () => {
    const { id } = useParams();
    const [blog, setBlog] = useState(null);
    const [author, setAuthor] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    const { user } = useContext(AuthContext);
    const navigate = useNavigate();

    useEffect(() => {
        fetchBlog();
    }, [id]);

    const fetchBlog = async () => {
        try {
            const response = await blogService.getBlog(id);
            setBlog(response.data);
            
            // Fetch author details
            const authorResponse = await userService.getUser(response.data.author_id);
            setAuthor(authorResponse.data);
        } catch (err) {
            setError('Failed to fetch blog');
        } finally {
            setLoading(false);
        }
    };

    const handleDelete = async () => {
        if (window.confirm('Are you sure you want to delete this blog?')) {
            try {
                await blogService.deleteBlog(id);
                navigate('/');
            } catch (err) {
                alert('Failed to delete blog');
            }
        }
    };

    if (loading) return <div className="loading">Loading...</div>;
    if (error) return <div className="error">{error}</div>;
    if (!blog) return <div className="error">Blog not found</div>;

    return (
        <div className="blog-detail">
            <h1>{blog.title}</h1>
            {author && (
                <div className="blog-meta">
                    <span className="author">By: {author.full_name} (@{author.username})</span>
                    <span className="date">{new Date(blog.created_at).toLocaleDateString()}</span>
                </div>
            )}
            <p className="description">{blog.description}</p>
            <div className="blog-content">{blog.content}</div>
            
            {user && (user.id === blog.author_id || user.role === 'admin') && (
                <div className="blog-actions">
                    <button onClick={() => navigate(`/edit/${id}`)}>Edit</button>
                    <button onClick={handleDelete} className="delete-btn">Delete</button>
                </div>
            )}
        </div>
    );
};

export default BlogDetail;

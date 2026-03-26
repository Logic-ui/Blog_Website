import React, { useState, useEffect } from 'react';
import { blogService } from '../services/api';
import BlogCard from '../components/BlogCard';
import '../styles/Home.css';

const Home = () => {
    const [blogs, setBlogs] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');

    useEffect(() => {
        fetchBlogs();
    }, []);

    const fetchBlogs = async () => {
        try {
            const response = await blogService.listBlogs();
            setBlogs(response.data);
        } catch (err) {
            setError('Failed to fetch blogs');
        } finally {
            setLoading(false);
        }
    };

    if (loading) return <div className="loading">Loading...</div>;
    if (error) return <div className="error">{error}</div>;

    return (
        <div className="home-container">
            <h1>Latest Blogs</h1>
            <div className="blogs-grid">
                {blogs.length > 0 ? (
                    blogs.map((blog) => <BlogCard key={blog.id} blog={blog} />)
                ) : (
                    <p>No blogs found</p>
                )}
            </div>
        </div>
    );
};

export default Home;

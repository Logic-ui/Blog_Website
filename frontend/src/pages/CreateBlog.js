import React, { useState, useContext } from 'react';
import { useNavigate } from 'react-router-dom';
import { blogService } from '../services/api';
import AuthContext from '../context/AuthContext';
import '../styles/CreateBlog.css';

const CreateBlog = () => {
    const [formData, setFormData] = useState({
        title: '',
        description: '',
        content: '',
    });
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();
    const { user } = useContext(AuthContext);

    if (!user || (user.role !== 'author' && user.role !== 'admin')) {
        return <div className="error">You must be an author to create a blog</div>;
    }

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData((prev) => ({
            ...prev,
            [name]: value,
        }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setError('');

        try {
            await blogService.createBlog(formData);
            navigate('/');
        } catch (err) {
            setError(err.response?.data?.detail || 'Failed to create blog');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="create-blog-container">
            <h2>Create New Blog</h2>
            {error && <div className="error">{error}</div>}
            <form onSubmit={handleSubmit}>
                <input
                    type="text"
                    name="title"
                    placeholder="Blog Title"
                    value={formData.title}
                    onChange={handleChange}
                    required
                />
                <input
                    type="text"
                    name="description"
                    placeholder="Brief Description"
                    value={formData.description}
                    onChange={handleChange}
                    required
                />
                <textarea
                    name="content"
                    placeholder="Blog Content"
                    value={formData.content}
                    onChange={handleChange}
                    rows="10"
                    required
                />
                <button type="submit" disabled={loading}>
                    {loading ? 'Publishing...' : 'Publish Blog'}
                </button>
            </form>
        </div>
    );
};

export default CreateBlog;

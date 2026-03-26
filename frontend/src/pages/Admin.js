import React, { useState, useEffect, useContext } from 'react';
import { noticeService } from '../services/api';
import { blogService } from '../services/api';
import { userService } from '../services/api';
import AuthContext from '../context/AuthContext';
import '../styles/Admin.css';

const Admin = () => {
    const { user } = useContext(AuthContext);
    const [notices, setNotices] = useState([]);
    const [allBlogs, setAllBlogs] = useState([]);
    const [allUsers, setAllUsers] = useState([]);
    const [activeTab, setActiveTab] = useState('notices');
    const [newNotice, setNewNotice] = useState({ title: '', content: '' });
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        if (user?.role !== 'admin') return;
        fetchData();
    }, [user]);

    const fetchData = async () => {
        try {
            const [noticesRes, blogsRes, usersRes] = await Promise.all([
                noticeService.listNotices(),
                blogService.listBlogs(),
                userService.listUsers(),
            ]);
            setNotices(noticesRes.data);
            setAllBlogs(blogsRes.data);
            setAllUsers(usersRes.data);
        } catch (err) {
            console.error('Failed to fetch data');
        }
    };

    const handleCreateNotice = async (e) => {
        e.preventDefault();
        setLoading(true);

        try {
            await noticeService.createNotice(newNotice);
            setNewNotice({ title: '', content: '' });
            fetchData();
        } catch (err) {
            alert('Failed to create notice');
        } finally {
            setLoading(false);
        }
    };

    const handleDeleteBlog = async (blogId) => {
        if (window.confirm('Are you sure?')) {
            try {
                await blogService.deleteBlog(blogId);
                fetchData();
            } catch (err) {
                alert('Failed to delete blog');
            }
        }
    };

    const handleDeleteNotice = async (noticeId) => {
        if (window.confirm('Are you sure?')) {
            try {
                await noticeService.deleteNotice(noticeId);
                fetchData();
            } catch (err) {
                alert('Failed to delete notice');
            }
        }
    };

    if (user?.role !== 'admin') {
        return <div className="error">Access denied. Admin only.</div>;
    }

    return (
        <div className="admin-container">
            <h1>Admin Dashboard</h1>
            
            <div className="admin-tabs">
                <button 
                    className={activeTab === 'notices' ? 'active' : ''} 
                    onClick={() => setActiveTab('notices')}
                >
                    Notices
                </button>
                <button 
                    className={activeTab === 'blogs' ? 'active' : ''} 
                    onClick={() => setActiveTab('blogs')}
                >
                    Manage Blogs
                </button>
                <button 
                    className={activeTab === 'users' ? 'active' : ''} 
                    onClick={() => setActiveTab('users')}
                >
                    Users
                </button>
            </div>

            {activeTab === 'notices' && (
                <div className="admin-section">
                    <h2>Create Notice</h2>
                    <form onSubmit={handleCreateNotice}>
                        <input
                            type="text"
                            placeholder="Notice Title"
                            value={newNotice.title}
                            onChange={(e) => setNewNotice({ ...newNotice, title: e.target.value })}
                            required
                        />
                        <textarea
                            placeholder="Notice Content"
                            value={newNotice.content}
                            onChange={(e) => setNewNotice({ ...newNotice, content: e.target.value })}
                            rows="5"
                            required
                        />
                        <button type="submit" disabled={loading}>
                            {loading ? 'Creating...' : 'Create Notice'}
                        </button>
                    </form>

                    <h2>All Notices</h2>
                    <div className="notices-list">
                        {notices.map((notice) => (
                            <div key={notice.id} className="notice-item">
                                <h3>{notice.title}</h3>
                                <p>{notice.content}</p>
                                <button 
                                    onClick={() => handleDeleteNotice(notice.id)}
                                    className="delete-btn"
                                >
                                    Delete
                                </button>
                            </div>
                        ))}
                    </div>
                </div>
            )}

            {activeTab === 'blogs' && (
                <div className="admin-section">
                    <h2>All Blogs</h2>
                    <div className="blogs-table">
                        <table>
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Author</th>
                                    <th>Created</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                {allBlogs.map((blog) => (
                                    <tr key={blog.id}>
                                        <td>{blog.title}</td>
                                        <td>{blog.author_id}</td>
                                        <td>{new Date(blog.created_at).toLocaleDateString()}</td>
                                        <td>
                                            <button 
                                                onClick={() => handleDeleteBlog(blog.id)}
                                                className="delete-btn"
                                            >
                                                Delete
                                            </button>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            )}

            {activeTab === 'users' && (
                <div className="admin-section">
                    <h2>All Users</h2>
                    <div className="users-table">
                        <table>
                            <thead>
                                <tr>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                {allUsers.map((u) => (
                                    <tr key={u.id}>
                                        <td>{u.username}</td>
                                        <td>{u.email}</td>
                                        <td>{u.role}</td>
                                        <td>{u.is_active ? 'Active' : 'Inactive'}</td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            )}
        </div>
    );
};

export default Admin;

import React from 'react';
import { Link } from 'react-router-dom';

const BlogCard = ({ blog }) => {
    return (
        <div className="blog-card">
            <h2>{blog.title}</h2>
            <p className="description">{blog.description}</p>
            <small className="date">{new Date(blog.created_at).toLocaleDateString()}</small>
            <Link to={`/blog/${blog.id}`} className="read-more">
                Read More →
            </Link>
        </div>
    );
};

export default BlogCard;

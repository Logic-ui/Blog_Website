import axios from 'axios';

// Use environment variable for API URL, fallback to localhost for development
const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:8000';

// Create axios instance
const apiClient = axios.create({
    baseURL: API_BASE_URL,
    headers: {
        'Content-Type': 'application/json',
    },
});

// Add token to requests
apiClient.interceptors.request.use((config) => {
    const token = localStorage.getItem('token');
    if (token) {
        config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
});

// User Services
export const userService = {
    register: (userData) => apiClient.post('/users/register', userData),
    login: (credentials) => apiClient.post('/users/login', credentials),
    getCurrentUser: () => apiClient.get('/users/me'),
    getUser: (userId) => apiClient.get(`/users/${userId}`),
    listUsers: () => apiClient.get('/users/'),
    updateUser: (userId, userData) => apiClient.put(`/users/${userId}`, userData),
    deleteUser: (userId) => apiClient.delete(`/users/${userId}`),
};

// Blog Services
export const blogService = {
    createBlog: (blogData) => apiClient.post('/blogs/', blogData),
    listBlogs: () => apiClient.get('/blogs/'),
    getBlog: (blogId) => apiClient.get(`/blogs/${blogId}`),
    getAuthorBlogs: (authorId) => apiClient.get(`/blogs/author/${authorId}`),
    updateBlog: (blogId, blogData) => apiClient.put(`/blogs/${blogId}`, blogData),
    deleteBlog: (blogId) => apiClient.delete(`/blogs/${blogId}`),
};

// Notice Services
export const noticeService = {
    createNotice: (noticeData) => apiClient.post('/notices/', noticeData),
    listNotices: () => apiClient.get('/notices/'),
    getNotice: (noticeId) => apiClient.get(`/notices/${noticeId}`),
    updateNotice: (noticeId, noticeData) => apiClient.put(`/notices/${noticeId}`, noticeData),
    deleteNotice: (noticeId) => apiClient.delete(`/notices/${noticeId}`),
};

export default apiClient;

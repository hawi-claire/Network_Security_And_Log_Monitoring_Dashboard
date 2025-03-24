---
layout: default
title: ServerGuard
---

<header class="site-header">
  <div class="container">
    <a class="site-title" href="#">ServerGuard</a>
    <nav class="site-nav">
      <a href="#features">Features</a>
      <a href="#about">About</a>
      <a href="https://github.com/yourusername/serverguard" class="btn-primary">View on GitHub</a>
    </nav>
  </div>
</header>

<section class="hero">
  <div class="container">
    <h1>ServerGuard</h1>
    <p class="tagline">Comprehensive network, security and log monitoring for Linux servers</p>
    <a href="https://your-deployed-app-url.com" class="btn-cta">Launch Dashboard</a>
  </div>
</section>

<section id="features" class="features">
  <div class="container">
    <h2>Key Features</h2>
    
    <div class="feature-item">
      <div class="feature-image">
        <img src="assets/images/network-monitoring.png" alt="Network Monitoring Dashboard">
      </div>
      <div class="feature-content">
        <h3>Network Monitoring</h3>
        <p>Real-time visibility into network traffic, bandwidth utilization, and connection status. Identify bottlenecks and optimize performance with customizable alerts and thresholds.</p>
      </div>
    </div>
    
    <div class="feature-item">
      <div class="feature-image">
        <img src="assets/images/security-dashboard.png" alt="Security Dashboard">
      </div>
      <div class="feature-content">
        <h3>Security Analytics</h3>
        <p>Detect and respond to potential security threats with comprehensive monitoring of authentication attempts, firewall logs, and system access. Visualize attack patterns and secure your infrastructure.</p>
      </div>
    </div>
    
    <div class="feature-item">
      <div class="feature-image">
        <img src="assets/images/log-analysis.png" alt="Log Analysis Dashboard">
      </div>
      <div class="feature-content">
        <h3>Centralized Logging</h3>
        <p>Aggregate logs from multiple servers in one place for easy troubleshooting and analysis. Search, filter, and create alerts based on log patterns to catch issues before they impact users.</p>
      </div>
    </div>
  </div>
</section>

<section id="about" class="about">
  <div class="container">
    <h2>About ServerGuard</h2>
    
    <div class="about-content">
      <h3>Our Story</h3>
      <p>ServerGuard was born from a personal challenge I faced while managing a small cluster of web servers for a community project. After experiencing a security breach that went undetected for days, I realized the critical need for comprehensive monitoring that's both powerful and accessible.</p>
      
      <p>What started as a simple script to alert me of suspicious activities evolved into a full-featured monitoring solution built on the robust Grafana LGTM stack (Loki, Grafana, Tempo, Mimir). This project represents countless hours of research, coding, and testing to create a tool I wish I had when I first started managing servers.</p>
      
      <p>This project was developed as part of my <a href="https://www.alxafrica.com">ALX Software Engineering</a> portfolio, completed during a 3-week sprint in March 2025.</p>
      
      <h3>Connect With Me</h3>
      <div class="team-links">
        <a href="https://linkedin.com/in/yourusername" class="social-link">
          <img src="assets/images/linkedin.svg" alt="LinkedIn">
          LinkedIn
        </a>
        <a href="https://github.com/yourusername" class="social-link">
          <img src="assets/images/github.svg" alt="GitHub">
          GitHub
        </a>
        <a href="https://twitter.com/yourusername" class="social-link">
          <img src="assets/images/twitter.svg" alt="Twitter">
          Twitter
        </a>
      </div>
      
      <div class="project-links">
        <a href="https://github.com/yourusername/serverguard" class="btn-secondary">View Source Code</a>
      </div>
    </div>
  </div>
</section>

{% if site.video_url %}
<section class="video-section">
  <div class="container">
    <h2>Watch ServerGuard in Action</h2>
    <div class="video-container">
      <iframe src="{{ site.video_url }}" frameborder="0" allowfullscreen></iframe>
    </div>
  </div>
</section>
{% endif %}

<footer class="site-footer">
  <div class="container">
    <p>&copy; 2025 ServerGuard | Built with ❤️ by <a href="https://github.com/yourusername">Your Name</a></p>
  </div>
</footer>

# Chapter 3 — Detailed Notes

Each section below pairs an expanded paragraph (left) with the corresponding image (right).

| Detailed notes | Image |
|---|---:|
| **Introduction — What is AngularJS?**

AngularJS is a framework for building single-page applications (SPAs). It uses HTML templates and TypeScript/JavaScript to create reusable components and rich client-side behavior. SPAs provide a smooth user experience by avoiding full page reloads and updating the UI dynamically.
 | ![Intro image](image-6.png) |
| **Angular as an SPA framework (HTML + TypeScript)**

Angular leverages TypeScript and declarative templates to make code more maintainable. The Angular CLI helps scaffold projects and enforces conventions that speed up development and reduce configuration overhead.
 | ![SPA image](image.png) |
| **Components & Project Structure**

A component packages the template (HTML), logic (TypeScript), and styles. Every application has a root component and many child components. Components communicate via @Input and @Output bindings and help organize the app into cohesive pieces.
 | ![Components image](image-1.png) |
| **Templates: Directives & Data Binding**

Templates control how data is displayed. Directives (structural and attribute) manipulate the DOM; data binding (property and event) connects the template to component data and user actions. These features enable responsive, interactive UIs without imperative DOM code.
 | ![Templates image](image-2.png) |
| **Services & Dependency Injection**

Services contain business logic and data access (HTTP). Dependency injection makes services available to components and ensures a testable, modular architecture. Use the HttpClient service for RESTful communication and observables for reactive flows.
 | ![Services image](image-3.png) |
| **Routing & Navigation**

The router maps URLs to components and supports route parameters, guards, and lazy loading. Routing lets SPAs behave like multi-page apps while maintaining a fast, client-side navigation experience.
 | ![Routing image](image-4.png) |
| **Angular Versions — 2+ vs AngularJS (1.x)**

Angular 2 was a major rewrite of AngularJS (1.x). Later releases (4,5,6...) are incremental improvements on the Angular (2+) platform. Focus on the modern Angular stack for new projects.
 | ![Versions image](image-5.png) |

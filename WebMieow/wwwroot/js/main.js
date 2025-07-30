/**
* Template Name: OnePage - v4.9.0
* Template URL: https://bootstrapmade.com/onepage-multipurpose-bootstrap-template/
* Author: BootstrapMade.com
* License: https://bootstrapmade.com/license/
*/
(function () {
    "use strict";

    /**
     * Easy selector helper function
     */
    const select = (el, all = false) => {
        if (!el.trim()) {
            console.error("Selector cannot be empty");
            return null;
        }
        return all ? [...document.querySelectorAll(el)] : document.querySelector(el);
    };

    /**
     * Easy event listener function
     */
    const on = (type, el, listener, all = false) => {
        let selectEl = select(el, all)
        if (selectEl) {
            if (all) {
                selectEl.forEach(e => e.addEventListener(type, listener))
            } else {
                selectEl.addEventListener(type, listener)
            }
        }
    }

    /**
     * Easy on scroll event listener 
     */
    const onscroll = (el, listener) => {
        el.addEventListener('scroll', listener)
    }

    /**
     * Navbar links active state on scroll
     */
    let navbarlinks = select('#navbar .scrollto', true)
    const navbarlinksActive = () => {
        let position = window.scrollY + 200
        navbarlinks.forEach(navbarlink => {
            if (!navbarlink.hash) return
            if (!navbarlink.hash.trim()) return // <-- Add this line
            let section = select(navbarlink.hash)
            if (!section) return
            if (position >= section.offsetTop && position <= (section.offsetTop + section.offsetHeight)) {
                navbarlink.classList.add('active')
            } else {
                navbarlink.classList.remove('active')
            }
        })
    }
    window.addEventListener('load', navbarlinksActive)
    onscroll(document, navbarlinksActive)

    /**
     * Scrolls to an element with header offset
     */
    const scrollto = (el) => {
        let header = select('#header')
        let offset = header.offsetHeight

        let elementPos = select(el).offsetTop
        window.scrollTo({
            top: elementPos - offset,
            behavior: 'smooth'
        })
    }

    /**
     * Toggle .header-scrolled class to #header when page is scrolled
     */
    let selectHeader = select('#header')
    if (selectHeader) {
        const headerScrolled = () => {
            if (window.scrollY > 100) {
                selectHeader.classList.add('header-scrolled')
            } else {
                selectHeader.classList.remove('header-scrolled')
            }
        }
        window.addEventListener('load', headerScrolled)
        onscroll(document, headerScrolled)
    }

    /**
     * Back to top button
     */
    let backtotop = select('.back-to-top')
    if (backtotop) {
        const toggleBacktotop = () => {
            if (window.scrollY > 100) {
                backtotop.classList.add('active')
            } else {
                backtotop.classList.remove('active')
            }
        }
        window.addEventListener('load', toggleBacktotop)
        onscroll(document, toggleBacktotop)
    }

    /**
     * Mobile nav toggle
     */
    on('click', '.mobile-nav-toggle', function (e) {
        select('#navbar').classList.toggle('navbar-mobile')
        this.classList.toggle('bi-list')
        this.classList.toggle('bi-x')
    })

    /**
     * Mobile nav dropdowns activate
     */
    on('click', '.navbar .dropdown > a', function (e) {
        if (select('#navbar').classList.contains('navbar-mobile')) {
            e.preventDefault()
            this.nextElementSibling.classList.toggle('dropdown-active')
        }
    }, true)

    /**
     * Scrool with ofset on links with a class name .scrollto
     */
    on('click', '.scrollto', function (e) {
        if (!this.hash) return; // ⛔ Bỏ qua nếu không có hash

        const target = select(this.hash)
        if (target) {
            e.preventDefault()

            let navbar = select('#navbar')
            if (navbar.classList.contains('navbar-mobile')) {
                navbar.classList.remove('navbar-mobile')
                let navbarToggle = select('.mobile-nav-toggle')
                navbarToggle.classList.toggle('bi-list')
                navbarToggle.classList.toggle('bi-x')
            }

            scrollto(this.hash)
        }
    }, true)


    /**
     * Scroll with ofset on page load with hash links in the url
     */
    window.addEventListener('load', () => {
        if (window.location.hash) {
            if (select(window.location.hash)) {
                scrollto(window.location.hash)
            }
        }
    });

    /**
     * Preloader
     */
    // let preloader = select('#preloader');
    // if (preloader) {
    //   window.addEventListener('load', () => {
    //     preloader.remove()
    //   });
    // }

    /**
     * Initiate glightbox 
     */
    const glightbox = GLightbox({
        selector: '.glightbox'
    });

    /**
     * Testimonials slider
     */
    new Swiper('.testimonials-slider', {
        speed: 600,
        loop: true,
        autoplay: {
            delay: 5000,
            disableOnInteraction: false
        },
        slidesPerView: 'auto',
        pagination: {
            el: '.swiper-pagination',
            type: 'bullets',
            clickable: true
        },
        breakpoints: {
            320: {
                slidesPerView: 1,
                spaceBetween: 20
            },

            1200: {
                slidesPerView: 3,
                spaceBetween: 20
            }
        }
    });

    /**
     * Porfolio isotope and filter
     */
    window.addEventListener('load', () => {
        let portfolioContainer = select('.portfolio-container');
        if (portfolioContainer) {
            let portfolioIsotope = new Isotope(portfolioContainer, {
                itemSelector: '.portfolio-item'
            });

            let portfolioFilters = select('#portfolio-flters li', true);

            on('click', '#portfolio-flters li', function (e) {
                e.preventDefault();
                portfolioFilters.forEach(function (el) {
                    el.classList.remove('filter-active');
                });
                this.classList.add('filter-active');

                portfolioIsotope.arrange({
                    filter: this.getAttribute('data-filter')
                });
                // portfolioIsotope.on('arrangeComplete', function() {
                //   AOS.refresh()
                // });
            }, true);
        }

    });

    /**
     * Initiate portfolio lightbox 
     */
    const portfolioLightbox = GLightbox({
        selector: '.portfolio-lightbox'
    });

    /**
     * Portfolio details slider
     */
    new Swiper('.portfolio-details-slider', {
        speed: 400,
        loop: true,
        autoplay: {
            delay: 5000,
            disableOnInteraction: false
        },
        pagination: {
            el: '.swiper-pagination',
            type: 'bullets',
            clickable: true
        }
    });

    /**
     * Animation on scroll
     */
    // window.addEventListener('load', () => {
    //   AOS.init({
    //     duration: 1000,
    //     easing: 'ease-in-out',
    //     once: true,
    //     mirror: false
    //   })
    // });

    /**
     * Initiate Pure Counter 
     */
    new PureCounter();

    document.addEventListener("DOMContentLoaded", () => {
        document.getElementById("btnCheck").addEventListener("click", () => {
            const contact = document.getElementById("contactInput")?.value.trim();
            const orderCode = document.getElementById("orderCode")?.textContent.trim();

            fetch("/data/orders.json")
                .then(res => res.json())
                .then(data => {
                    const order = data.orders.find(o =>
                        o.contact === contact && o.orderCode === orderCode);

                    if (order && order.status === "success") {
                        document.getElementById("cardCode").innerHTML = `
                        <h3>Mã thẻ của bạn:</h3>
                        <p style="font-size: 20px; font-weight: bold;">${order.card}</p>`;
                    } else {
                        alert("Chưa xác nhận thanh toán hoặc sai thông tin.");
                    }
                });
        });
        console.log("contact:", contact);
        console.log("orderCode:", orderCode);
        console.log("Fetched orders:", data.orders);

    });

    const plan = `${type} - ${amount}đ`;
    let serviceType = "Card";

    // Gắn logic phân loại
    if (["Steam Wallet", "Google Play", "iTunes", "Netflix", "Spotify"].includes(type)) {
        serviceType = "Subscription";
    }

    const query = `/Shop/Payment?email=${encodeURIComponent(contact)}&plan=${encodeURIComponent(plan)}&amount=${amount}&serviceType=${serviceType}`;

    // Razor kiểm tra đăng nhập
    const isLoggedIn = document.getElementById('isLoggedIn').value === "true";
    if (!isLoggedIn) {
        alert("Vui lòng đăng nhập để mua hàng.");
        window.location.href = "/Account/Login";
        return;
    }


    document.querySelectorAll('.btn-buy-now').forEach((btn) => {
        btn.addEventListener('click', () => {
            const box = btn.closest('.box');

            const type = box.querySelector('.select-type').value;
            const amount = box.querySelector('.select-amount').value;

            const plan = `${type} - ${amount}đ`;

            // Tự xác định loại dịch vụ
            let serviceType = "Card";
            if (["Steam Wallet", "Google Play", "iTunes", "Netflix", "Spotify"].includes(type)) {
                serviceType = "Subscription";
            }

            // Tạo URL và chuyển hướng
            const query = `/Shop/Payment?plan=${encodeURIComponent(plan)}&amount=${amount}&serviceType=${serviceType}`;
            window.location.href = query;
        });
    });





})()
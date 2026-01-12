// Topbar scroll effect
const html = document.documentElement
const topbar = document.getElementById("layout-topbar")
if (topbar) {
    const handleScroll = () =>
        topbar.setAttribute("data-at-top", window.scrollY < 30 ? "true" : "false")

    window.addEventListener("scroll", handleScroll, { passive: true })
    handleScroll()
}

// Theme toggle with localStorage persistence
document.querySelectorAll("[data-theme-control]").forEach((control) => {
    control.addEventListener("click", () => {
        const theme = control.getAttribute("data-theme-control")
        if (theme === "system") {
            html.removeAttribute("data-theme")
            localStorage.removeItem("theme")
        } else {
            html.setAttribute("data-theme", theme)
            localStorage.setItem("theme", theme)
        }
    })
})

// Restore saved theme on page load
const savedTheme = localStorage.getItem("theme")
if (savedTheme) {
    html.setAttribute("data-theme", savedTheme)
}

// Swiper initialization for testimonials (if present)
if (document.querySelector("#testimonial-swiper")) {
    new Swiper("#testimonial-swiper", {
        autoplay: {
            delay: 5000,
        },
        loop: true,
        navigation: {
            enabled: true,
            nextEl: ".testimonials-button-next",
            prevEl: ".testimonials-button-prev",
        },
        pagination: {
            clickable: true,
            el: ".swiper-pagination",
        },
    })
}

// Smooth scroll for anchor links
document.querySelectorAll('a[href^="/#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        const targetId = this.getAttribute('href').slice(2)
        const targetElement = document.getElementById(targetId)

        if (targetElement) {
            e.preventDefault()
            targetElement.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            })

            // Update URL without triggering page reload
            history.pushState(null, null, this.getAttribute('href'))
        }
    })
})

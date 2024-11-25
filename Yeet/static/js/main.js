fetch("/sing-up", {
	method: "POST",
	headers: {
		"Content-Type": "application/json",
	},
	body: JSON.stringify({ currentPath: window.location.pathname }),
})
	.then((response) => response.json())
	.then((data) => {
		console.log(data); // Verifica la información devuelta
		if (data.pageType === "signup") {
			var script = document.createElement("script");
			script.src = "/static/js/singup.js";
			document.body.appendChild(script);
		}
	});

document.querySelectorAll('img').forEach(img => {
	img.onerror = () => {
		img.src = 'static/img/none.png';
	};
});


async function loadCartId() {
    let session_id = localStorage.getItem('session_id');
    if (!session_id) {
        const response = await fetch('/getCarrito');
        if (response.ok) {
            const data = await response.json();
            session_id = data.session_id;
            localStorage.setItem('session_id', session_id);
        }
    }
    return session_id;
}

async function syncCartWithServer() {
    const cartId = await loadCartId();
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    await fetch('/sync-cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ cart_id: cartId, cart }),
    });
}
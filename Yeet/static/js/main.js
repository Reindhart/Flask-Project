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

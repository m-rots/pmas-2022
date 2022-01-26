const textOnly = (innerHtml) => `<div class="text-only">${innerHtml}</div>`
const superSpeedMode = false

window.onload = () => {
    liveConnection()
}

function liveConnection() {
    const mainBody = document.getElementById("replace-me");
    mainBody.innerHTML = textOnly("Connecting to server...")

    const sse = new EventSource("http://localhost:3031/api/chat");

    let cancellables = []
    let nextAppearAt = Date.now()

    sse.addEventListener("html", (event) => {
        if (superSpeedMode) {
            mainBody.innerHTML = event.data
            return
        }

        const now = Date.now()
        const waitingTime = nextAppearAt - now

        if (waitingTime > 0) {
            nextAppearAt += 2500

            const timeout = setTimeout(() => {
                mainBody.innerHTML = event.data
            }, waitingTime)

            cancellables.push(timeout)
        } else {
            nextAppearAt = now + 2500
            mainBody.innerHTML = event.data
        }
    });

    sse.onopen = () => {
        mainBody.innerHTML = textOnly("Connected!")
    }

    document.getElementById("chatbox").addEventListener("submit", (event) => {
        event.preventDefault()

        const textInput = document.getElementById("chatbox-text");

        // Retrieve the text from the chatbox
        const text = textInput.value
        if (!text) {
            return
        }

        // Remove the text from the chatbox
        textInput.value = ""

        // Clear timeouts so we can display new next right away
        for (const timeout of cancellables) {
            clearTimeout(timeout)
        }

        // New list of cancellables
        cancellables = []
        nextAppearAt = Date.now()

        const url = new URL("http://localhost:3031/api/chat")
        url.searchParams.set("msg", text)

        fetch(url, {
            method: "POST"
        });
    });
}
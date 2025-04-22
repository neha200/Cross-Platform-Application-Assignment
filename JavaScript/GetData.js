// Call the function to fetch and display data
window.onload = function () {
    getDataUsingFetch();
}

function getDataUsingFetch() {
    fetch('https://parseapi.back4app.com/classes/assignmentClass', {
        method: "GET",
        headers: {
            "Content-type": "application/json; charset=UTF-8",
            "X-Parse-Application-Id": "r9H2fz2GbvsJqiDeeWV26cfq0tYugAOx2XGtqPsx",
            "X-Parse-REST-API-Key": "EmxKg0TsPxqasjbxjUbttvQCmbpNx7CFhZ8zRvoX"
        }
    })
    .then(response => response.json())
    .then(json => {
        // Process the fetched data and display it in the grid
        const dataContainer = document.getElementById("data-container");

        // Assuming the API response is an array of objects
        json.results.forEach(item => {
            const gridItem = document.createElement("div");
            gridItem.classList.add("grid-item");
            gridItem.innerHTML = `
                <p><strong>User ID:</strong> ${item.objectId}</p>
                <p><strong>Last Name:</strong> ${item.lname}</p>
                <p><strong>First Name:</strong> ${item.fname}</p>
                <p><strong>Age:</strong> ${item.age}</p>
                <p><strong>Created At:</strong> ${new Date(item.createdAt).toLocaleString()}</p>
                <p><strong>Updated At:</strong> ${new Date(item.updatedAt).toLocaleString()}</p>
            `;
            dataContainer.appendChild(gridItem);
        });
    })
    .catch(err => console.log(err));
}
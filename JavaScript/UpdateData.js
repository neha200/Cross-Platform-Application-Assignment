function updateDataUsingFetch() {
    const updateId = document.getElementById("update-id").value;
    const updatedFname = document.getElementById("update-fname").value;
    const updatedLname = document.getElementById("update-lname").value;
    const updatedAge = document.getElementById("update-age").value;
 
    if (!updateId && (!updatedFname && !updatedLname && !updatedAge)) {
        alert("Please enter ID and at least one field to update.");
        return;
    }
 
    const _data = {};
 
    if (updatedFname) {
        _data.fname = updatedFname;
    }
    if (updatedLname) {
        _data.lname = updatedLname;
    }
    if (updatedAge) {
        _data.age = parseInt(updatedAge);
    }
 
    fetch(`https://parseapi.back4app.com/classes/assignmentClass/${updateId}`, {
        method: "PUT",
        headers: {
            "X-Parse-Application-Id": "r9H2fz2GbvsJqiDeeWV26cfq0tYugAOx2XGtqPsx",
            "X-Parse-REST-API-Key": "EmxKg0TsPxqasjbxjUbttvQCmbpNx7CFhZ8zRvoX",
            "Content-Type": "application/json"
        },
        body: JSON.stringify(_data)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Failed to update data");
        }
        return response.json();
    })
    .then(json => {
        console.log(json);
        alert(`Data with ID ${updateId} updated successfully.`);
		//getDataUsingFetch();
    })
    .catch(err => {
        console.error("Update failed:", err);
        alert("Update failed. Check console for details.");
    });
}
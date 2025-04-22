function addDataUsingFetch() {
    const newFname = document.getElementById("add-fname").value;
    const newLname = document.getElementById("add-lname").value;
    const newAge = document.getElementById("add-age").value;
 
    if (!newFname || !newLname || !newAge) {
        alert("One of the following is missing: first name, last name, age.");
        return;
    }
 
    const newData = {
        fname: newFname,
        lname: newLname,
        age: parseInt(newAge)
    };
 
    fetch("https://parseapi.back4app.com/classes/assignmentClass", {
        method: "POST",
        headers: {
            "X-Parse-Application-Id": "r9H2fz2GbvsJqiDeeWV26cfq0tYugAOx2XGtqPsx",
            "X-Parse-REST-API-Key": "EmxKg0TsPxqasjbxjUbttvQCmbpNx7CFhZ8zRvoX",
            "Content-Type": "application/json"
        },
        body: JSON.stringify(newData)
    })
    .then(response => response.json())
    .then(json => {
        console.log(json);
        alert(`Data added successfully! Object ID: ${json.objectId}`);
		//getDataUsingFetch();
    })
    .catch(err => {
        console.error("Add failed:", err);
        alert("Failed to add data. Check console for details.");
    });
}
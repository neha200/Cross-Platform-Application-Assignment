function deleteDataUsingFetch() {
  const deleteId = document.getElementById("delete-id").value;
  if (!deleteId) {
    alert("Please enter an ID to delete.");
    return;
  }

  fetch(
    `https://parseapi.back4app.com/classes/assignmentClass/${deleteId}`,
    {
      method: "DELETE",
      headers: {
        "X-Parse-Application-Id": "r9H2fz2GbvsJqiDeeWV26cfq0tYugAOx2XGtqPsx",
        "X-Parse-REST-API-Key": "EmxKg0TsPxqasjbxjUbttvQCmbpNx7CFhZ8zRvoX",
        "Content-Type": "application/json",
      },
    }
  )
    .then((response) => {
      if (!response.ok) {
        throw new Error("Failed to delete data");
      }
      return response.json();
    })
    .then((json) => {
      console.log(json);
      alert(`Data with ID ${deleteId} deleted successfully.`);
      getDataUsingFetch();
    })

    .catch((err) => {
      console.error("Delete failed:", err);
      alert("Delete failed. Check console for details.");
    });
}

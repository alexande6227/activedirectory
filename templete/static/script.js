document.addEventListener("DOMContentLoaded", function () {
    fetch("/data")
        .then(response => response.json())
        .then(data => {
            renderUserList(data);
        })
        .catch(error => console.error("❌ Error cargando el archivo JSON:", error));
});

function renderUserList(data) {
    const ouList = document.getElementById("ouList");
    ouList.innerHTML = "";

    data.forEach(ou => {
        let ouItem = document.createElement("div");
        ouItem.className = "ou-item";
        ouItem.textContent = ou.OU;

        let userList = document.createElement("div");
        userList.className = "user-list";

        ou.Usuarios.forEach(user => {
            let userEntry = document.createElement("p");
            userEntry.textContent = `${user["Nombre Completo"]} (${user.Usuario})`;
            userList.appendChild(userEntry);
        });

        ouItem.addEventListener("click", () => {
            userList.style.display = userList.style.display === "none" ? "block" : "none";
        });

        ouItem.appendChild(userList);
        ouList.appendChild(ouItem);
    });
}

document.getElementById("search").addEventListener("input", function () {
    let searchText = this.value.toLowerCase();

    fetch("/data")
        .then(response => response.json())
        .then(data => {
            let filteredData = data.map(ou => {
                let filteredUsers = ou.Usuarios.filter(user =>
                    user["Nombre Completo"].toLowerCase().includes(searchText) ||
                    user.Usuario.toLowerCase().includes(searchText)
                );
                return { OU: ou.OU, Usuarios: filteredUsers };
            }).filter(ou => ou.Usuarios.length > 0);
            renderUserList(filteredData);
        });
});

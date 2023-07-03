import TestComponent from "./components/TestComponent";
import dimension from "./apis/dimension";
import { createRoot } from "react-dom/client";

window.___hitler = {
	id: "hitler",
	apis: [dimension],
	components: [TestComponent],
};

const mode = "";
console.log('cosmos Working!');

if (mode === "development") {
	const domNode = document.getElementById("root");
	const root = createRoot(domNode);
	root.render(
		<TestComponent.component
			attr="hello"
			a2="gfdgdfgd"
			a3="gfdgdgr"
			a4="34342df"
		/>
	);
}

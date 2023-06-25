import dashboard from './api/dashboard';
import hood from './api/hood';
import { bDashboard } from './bundles/dashboard';
import Create from './components/collective/Create';
import SpellBook from './components/SpellBook';
const declare = {
	api: {
		dashboard,
		hood
	},
	bundles: {
		bDashboard
	},
	components: {
		Create,
		SpellBook
	}
};

export default declare;

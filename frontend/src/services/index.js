const requireModule = require.context(".", false, /.js$/);
const modules = {};

requireModule.keys().forEach(filename => {
    const moduleName = filename.replace(/(\.\/|.js)/g, "").replace(/^\w/, c => c.toUpperCase());
    if (moduleName !== 'Index') {
        modules[moduleName] = requireModule(filename).default || requireModule(filename);
    }
});

export default modules;
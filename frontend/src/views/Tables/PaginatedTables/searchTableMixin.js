import Fuse from 'fuse.js';
export default {
  computed: {
    /***
     * Returns a page from the searched data or the whole data. Search is performed in the watch section below
     */
    queriedData() {
      let result = this.tableData;
      if (this.searchedData.length > 0) {
        result = this.searchedData;
      } else {
        if (this.searchQuery) {
          result = []
        }
      }
      result = this.customSort(result)
      return result.slice(this.from, this.to);
    },

    to() {
      let highBound = this.from + this.pagination.perPage;
      return this.total < highBound ? this.total : highBound;
    },
    from() {
      return this.pagination.perPage * (this.pagination.currentPage - 1);
    },
    total() {
      return this.searchedData.length > 0 ? this.searchedData.length : this.tableData.length;
    }
  },
  data() {
    return {
      columnSorted: 'id',
      sortingDirection: 'ascending',
      pagination: {
        perPage: 5,
        currentPage: 1,
        perPageOptions: [5, 10, 25, 50],
        total: 0
      },
      searchQuery: '',
      searchedData: [],
      searchColumns: ['name', 'email'],
      fuseSearch: null
    }
  },
  methods: {
    customSort( data ) {
      return [...data].sort((a, b) => {
        let aVal = isNaN(a[this.columnSorted]) ? a[this.columnSorted] : parseFloat(a[this.columnSorted])
        let bVal = isNaN(b[this.columnSorted]) ? b[this.columnSorted] : parseFloat(b[this.columnSorted])
        if (this.sortingDirection === 'ascending') {
          return aVal > bVal ? 1 : -1
        }
        return bVal > aVal ? 1 : -1
      })
    },
    sortChange({ prop, order }) {
      this.columnSorted = ['ascending', 'descending'].includes(order) ? prop : 'id'
      this.sortingDirection = order || 'ascending'
    }
  },
  mounted() {
    // Fuse search initialization.
    this.fuseSearch = new Fuse([], {
      keys: this.searchColumns,
      threshold: 0.3
    });
  },
  watch: {
    /**
     * Searches through the table data by a given query.
     * NOTE: If you have a lot of data, it's recommended to do the search on the Server Side and only display the results here.
     * @param value of the query
     */
    searchQuery(value) {
      this.fuseSearch.setCollection(this.tableData)
      let result = [...this.tableData]
      if (value !== '') {
        result = this.fuseSearch.search(value);
        this.searchedData = result.map(r => r.item);
      }
      else {
        this.searchedData = this.tableData
      }
    }
  }
}

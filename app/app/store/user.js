export const state = () => ({
  user: {},
  error: null,
});

export const mutations = {
  setUser(state, user) {
    state.user = user;
  },
  setError(state, error) {
    state.error = error;
  },
  clearUser(state) {
    state.user = {};
  },
  clearError(state) {
    state.error = null;
  },
};

export const actions = {
  async fetchUser({ commit }) {
    try {
      const response = await this.$axios.$get(
        `${process.env.baseUrl}/api/v1/users/show_current_user`
      );
      commit("setUser", response);
      commit("clearError");
    } catch (error) {
      commit("setError", error.response.data.error);
    }
  },

  async editUser({ commit }, { userId, params }) {
    try {
      const response = await this.$axios.$put(
        `${process.env.baseUrl}/api/v1/users/${userId}`,
        params
      );
      commit("setUser", response);
      commit("clearError");
      this.$router.push(`/user`);
    } catch (error) {
      commit("setError", error.response.data.error);
    }
  },

  clearUser({ commit }) {
    commit("clearUser");
  },
};
